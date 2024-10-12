abstract class HwDetailsEvent {
  const HwDetailsEvent();
}

class GetImagesEvent extends HwDetailsEvent {
  final int studentTaskId;
  GetImagesEvent({required this.studentTaskId});
}

class DisplayUploadingTasksEvent extends HwDetailsEvent{}
class ClearImagesEvent extends HwDetailsEvent {}
class SubmitImagesEvent extends HwDetailsEvent {
  final int taskId;

  SubmitImagesEvent(this.taskId);
}

