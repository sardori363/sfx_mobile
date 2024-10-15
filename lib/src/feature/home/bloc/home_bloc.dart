import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:sfx/src/data/entity/stats_model.dart';
import 'package:sfx/src/data/entity/task_model.dart';
import 'package:sfx/src/data/repository/task_repository.dart';
import 'package:sfx/src/feature/home/bloc/home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc():super(HomeState(pageState: HomePageState.init, tasksData: const [], topicsData: const [], stats: Statistics(allTasks: 0, completedTasks: 0, student: ""))) {
    on<GetTasksEvent>(_getTasks);
  }

  int currentTopicId = 0;

  void _getTasks(GetTasksEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(pageState: HomePageState.loading));
    List<TaskWStatus>? result;
    if(event.topicNumber == 0){
      result = await TaskRepository.getTasksWStatus();
    } else{
      result = await TaskRepository.getTasksWStatusByTopicId(event.topicNumber);
    }
    var resultTopics = await TaskRepository.getAllTopics();
    var resultStats = await TaskRepository.getStats();
    if (result != null && resultTopics != null && resultStats != null) {
      emit(
        state.copyWith(pageState: HomePageState.success, tasksData: result, topicsData: resultTopics, stats: resultStats),
      );
    } else {
      log("home bloc get arenas error");
      emit(state.copyWith(pageState: HomePageState.error));
    }
  }
}