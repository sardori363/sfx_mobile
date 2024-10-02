import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:sfx/src/data/entity/studentTaskImage_model.dart';
import 'package:sfx/src/data/repository/studentTask_repository.dart';
import 'package:sfx/src/feature/home/bloc/hwdetails_state.dart';

import 'hwdetails_event.dart';

class HWDetailsBloc extends Bloc<HwDetailsEvent, HWDetailsState> {
  HWDetailsBloc() : super(HWDetailsState(imagesForDetailsPage: StudentTaskImage(student: 0, id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), images: [], status: "", task: 0), pageState: HWDetailsPageState.init)) {
    on<GetImagesEvent>(_getImages);
  }

  void _getImages(GetImagesEvent event, Emitter<HWDetailsState> emit) async {
    emit(state.copyWith(pageState: HWDetailsPageState.loading));
    StudentTaskImage? result = await StudentTaskRepository.getImages(event.studentTaskId);
    if (result != null) {
      emit(
        state.copyWith(pageState: HWDetailsPageState.success, imagesForDetailsPage: result),
      );
    } else {
      emit(state.copyWith(pageState: HWDetailsPageState.noImage));
    }
  }
}
