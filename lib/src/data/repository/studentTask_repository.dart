import 'dart:convert';
import 'dart:developer';

import 'package:sfx/src/common/server/api/api.dart';
import 'package:sfx/src/common/server/api/api_constants.dart';
import 'package:sfx/src/data/entity/stats_model.dart';
import 'package:sfx/src/data/entity/student_task_model.dart';
import 'package:sfx/src/data/entity/task_model.dart';
import 'package:sfx/src/data/entity/topic_model.dart';
import 'package:sfx/src/data/entity/topicwihnotasks_model.dart';

import '../entity/studentTaskImage_model.dart';

class StudentTaskRepository {
  static Future<StudentTaskImage?> getImages(int studentTaskId) async {
    try {
      var imagesJson = await ApiService.getWithToken("en/tasks/student-tasks/$studentTaskId/v1/", {});
      if (imagesJson != null) {
        StudentTaskImage images = StudentTaskImage.fromJson(jsonDecode(imagesJson));
        return images;
      } else {
        log("API response is null");
        return null;
      }
    } catch (e, stacktrace) {
      log("Error fetching tasks: $e");
      log("Stacktrace: $stacktrace");
      return null;
    }
  }
}
