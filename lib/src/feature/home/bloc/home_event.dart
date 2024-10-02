part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GetTasksEvent extends HomeEvent {
  final int topicNumber;
  GetTasksEvent({required this.topicNumber});
}

class DisplayUploadingTasksEvent extends HomeEvent {}