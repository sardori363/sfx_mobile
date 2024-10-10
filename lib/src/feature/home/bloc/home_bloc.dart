import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfx/src/common/server/api/api.dart';
import 'package:sfx/src/common/server/api/api_constants.dart';
import 'package:sfx/src/data/entity/stats_model.dart';
import 'package:sfx/src/data/entity/student_task_model.dart';
import 'package:sfx/src/data/repository/task_repository.dart';
import 'package:sfx/src/feature/home/bloc/home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc():super(HomeState(pageState: HomePageState.init, tasksData: const [], topicsData: const [], stats: Statistics(allTasks: 0, completedTasks: 0, student: ""))) {
    on<GetTasksEvent>(_getTasks);
  }

  int currentTopicId = 4;

  void _getTasks(GetTasksEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(pageState: HomePageState.loading));
    var result = await TaskRepository.getTasksWStatusByTopicId(event.topicNumber);
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



  // StudentTask setCurrentStudentTask(int currentTask){
  //   StudentTask currentStudentTask;
  //   if (state.studentTaskData.isNotEmpty) {
  //     currentStudentTask = state.studentTaskData.firstWhere(
  //           (task) => task.task == currentTask,
  //       orElse: () => StudentTask(
  //           id: 1,
  //           status: "Left",
  //           createdAt: DateTime.now(),
  //           updatedAt: DateTime.now(),
  //           student: 1,
  //           task: currentTask
  //       ),
  //     );
  //   } else {
  //     currentStudentTask = StudentTask(
  //         id: 1,
  //         status: "Left",
  //         createdAt: DateTime.now(),
  //         updatedAt: DateTime.now(),
  //         student: 1,
  //         task: currentTask
  //     );
  //   }
  //
  //   return currentStudentTask;
  // }
}