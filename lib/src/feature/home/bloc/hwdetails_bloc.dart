import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfx/src/common/server/api/api.dart';
import 'package:sfx/src/common/server/api/api_constants.dart';
import 'package:sfx/src/data/entity/studentTaskImage_model.dart';
import 'package:sfx/src/data/repository/studentTask_repository.dart';
import 'package:sfx/src/feature/home/bloc/hwdetails_state.dart';

import 'hwdetails_event.dart';

class HWDetailsBloc extends Bloc<HwDetailsEvent, HWDetailsState> {
  HWDetailsBloc() : super(HWDetailsState(imagesForDetailsPage: StudentTaskImage(student: 0, id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), images: [], status: "", task: 0), pageState: HWDetailsPageState.init, isFileTypeFile: false)) {
    on<GetImagesEvent>(_getImages);
    on<ClearImagesEvent>(_clearImages);
    on<DisplayUploadingTasksEvent>(_pickImages);
  }

  void _getImages(GetImagesEvent event, Emitter<HWDetailsState> emit) async {
    emit(state.copyWith(pageState: HWDetailsPageState.loading));
    try{
      StudentTaskImage? result = await StudentTaskRepository.getImages(event.studentTaskId);
      if (result != null) {
        log(result.images[0].imageUrl);
        emit(
          state.copyWith(pageState: HWDetailsPageState.success, imagesForDetailsPage: result, isFileTypeFile: false),
        );
      } else {
        emit(state.copyWith(pageState: HWDetailsPageState.noImage,imagesForDetailsPage: StudentTaskImage(student: 0, id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), images: [], status: "", task: 0), isFileTypeFile: false));
      }
    }catch(e){
      emit(state.copyWith(pageState: HWDetailsPageState.noImage, imagesForDetailsPage: StudentTaskImage(student: 0, id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), images: [], status: "", task: 0), isFileTypeFile: false));
    }
  }

  List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages(DisplayUploadingTasksEvent event, Emitter<HWDetailsState> emit) async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      List<File> fileList = pickedFiles.map((xFile) => File(xFile.path)).toList();

      StudentTaskImageFile studentTaskImageFile = StudentTaskImageFile(
        id: 100,
        images: fileList,
        status: 'Pending',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        student: 101,
        task: 202,
      );
      _selectedImages.addAll(pickedFiles);
      emit(state.copyWith(pageState: HWDetailsPageState.success, imagesForDetailsPage: studentTaskImageFile, isFileTypeFile: true));
    }
  }

  Future<bool> uploadImages(int taskId) async {
    try {
      List<MultipartFile> imageFiles = [];

      for (var image in _selectedImages) {
        imageFiles.add(await MultipartFile.fromFile(image.path));
      }

      FormData formData = FormData.fromMap({
        'task_id': taskId,
        'images': imageFiles,
      });

      String? response = await ApiService.postTask(ApiConst.postTask, formData);

      if (response != null) {
        log('Upload successful: $response');
        return true;
      } else {
        log('Upload failed');
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        log('Dio error: ${e.response?.data}');
      } else {
        log('Error without response: $e');
      }
      return false;
      rethrow;
    } catch (e) {
      log('Error uploading images: $e');
      return false;
    }
  }

  Future<bool> submitImages(int taskId) async {
    late bool result;
    if (_selectedImages.isNotEmpty) {
      result = await uploadImages(taskId);
      log("$result");
      _selectedImages.clear();
    }

    return result;
  }

  void _clearImages(ClearImagesEvent event, Emitter<HWDetailsState> emit) {
    _selectedImages.clear();
    log("clearing");
    emit(state.copyWith(
      imagesForDetailsPage: StudentTaskImage(student: 0, id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), images: [], status: "", task: 0),
      pageState: HWDetailsPageState.init,
    ));
  }

}
