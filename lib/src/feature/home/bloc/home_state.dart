
import 'package:equatable/equatable.dart';
import 'package:sfx/src/data/entity/stats_model.dart';
import 'package:sfx/src/data/entity/student_task_model.dart';
import 'package:sfx/src/data/entity/task_model.dart';
import 'package:sfx/src/data/entity/topicwihnotasks_model.dart';

enum HomePageState { init, loading, success, error }

class HomeState extends Equatable{
  final HomePageState pageState;
  final List<TaskWStatus> tasksData;
  final List<TopicW> topicsData;
  final Statistics stats;

  const HomeState({
    required this.pageState,
    required this.tasksData,
    required this.topicsData,
    required this.stats
  });
  HomeState copyWith({
    HomePageState? pageState,
    List<TaskWStatus>? tasksData,
    List<TopicW>? topicsData,
    Statistics? stats
  }) {
    return HomeState(
      pageState: pageState ?? this.pageState,
      tasksData: tasksData ?? this.tasksData,
      topicsData: topicsData ?? this.topicsData,
      stats: stats ?? this.stats
    );
  }

  @override
  List<Object?> get props => [pageState, tasksData, topicsData, stats];
}