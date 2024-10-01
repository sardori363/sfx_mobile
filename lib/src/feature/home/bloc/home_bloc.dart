import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:sfx/src/data/entity/stats_model.dart';
import 'package:sfx/src/data/repository/topic_repository.dart';
import 'package:sfx/src/feature/home/bloc/home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
      pageState: HomePageState.init, tasksData: const [], topicsData: const [], studentTaskData: const [], stats: Statistics(allTasks: 0, completedTasks: 0, student: ""))) {
    on<GetTasksEvent>(_getTasks);
  }

  int currentTopicId = 4;

  void _getTasks(GetTasksEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(pageState: HomePageState.loading));
    var result = await TaskRepository.getTopic(event.topicNumber);
    var resultTopics = await TaskRepository.getAllTopics();
    var resultStatus = await TaskRepository.getAllStatus();
    var resultStats = await TaskRepository.getStats();
    if (result != null && resultTopics != null && resultStatus != null && resultStats != null) {
      emit(
        state.copyWith(pageState: HomePageState.success, tasksData: result, topicsData: resultTopics, studentTaskData: resultStatus, stats: resultStats),
      );
    } else {
      log("home bloc get arenas error");
      emit(state.copyWith(pageState: HomePageState.error));
    }
  }

  void _postTask(GetTasksEvent event, Emitter<HomeState> emit) async {
    var result = await TaskRepository.getTopic(event.topicNumber);
    var resultTopics = await TaskRepository.getAllTopics();
    var resultStatus = await TaskRepository.getAllStatus();
    var resultStats = await TaskRepository.getStats();
    if (result != null && resultTopics != null && resultStatus != null && resultStats != null) {
      emit(
        state.copyWith(pageState: HomePageState.success, tasksData: result, topicsData: resultTopics, studentTaskData: resultStatus, stats: resultStats),
      );
    } else {
      log("home bloc get arenas error");
      emit(state.copyWith(pageState: HomePageState.error));
    }
  }
}