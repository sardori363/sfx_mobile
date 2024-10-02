import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfx/src/common/server/api/api.dart';
import 'package:sfx/src/common/server/api/api_constants.dart';
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

  List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      for (XFile file in pickedFiles) {
        log("image info: ");
        print('File Name: ${file.name}');
        print('File Path: ${file.path}');
        print('File Size: ${file.length()} bytes');
      }
      _selectedImages.addAll(pickedFiles);
    }
  }

  Future<void> uploadImages(int taskId) async {
    try {
      List<MultipartFile> imageFiles = [];

      for (var image in _selectedImages) {
        imageFiles.add(await MultipartFile.fromFile(image.path));
      }

      FormData formData = FormData.fromMap({
        'task_id': taskId,
        'images': imageFiles, // Send all images
      });

      log("Form Data Fields:");
      for (var field in formData.fields) {
        log('${field.key}: ${field.value}');
      }

      log("Form Data Files:");
      for (var file in formData.files) {
        log('${file.key}: ${file.value.filename}');
      }

      String? response = await ApiService.postTask(ApiConst.postTask, formData);

      if (response != null) {
        log('Upload successful: $response');
      } else {
        log('Upload failed');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        log('Dio error: ${e.response?.data}');
      } else {
        log('Error without response: $e');
      }
      rethrow;
    } catch (e) {
      log('Error uploading images: $e');
    }
  }

  void submitImages(int taskId) async {
    if (_selectedImages.isNotEmpty) {
      await uploadImages(taskId);
      _selectedImages.clear();
    }
  }
}