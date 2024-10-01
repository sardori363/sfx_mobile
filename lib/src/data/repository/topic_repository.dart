import 'dart:convert';
import 'dart:developer';

import 'package:sfx/src/common/server/api/api.dart';
import 'package:sfx/src/common/server/api/api_constants.dart';
import 'package:sfx/src/data/entity/stats_model.dart';
import 'package:sfx/src/data/entity/student_task_model.dart';
import 'package:sfx/src/data/entity/task_model.dart';
import 'package:sfx/src/data/entity/topic_model.dart';
import 'package:sfx/src/data/entity/topicwihnotasks_model.dart';

class TaskRepository {
  static Future<List<Task>?> getTopic(int topicNumber) async {
    try {
      var topicsJson = await ApiService.getWithToken("en/tasks/topics/$topicNumber/tasks", {});
      if (topicsJson != null) {
        Topic topic = Topic.fromJson(jsonDecode(topicsJson));
        return topic.tasks;
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

  static Future<List<TopicW>?> getAllTopics() async {
    try {
      var topicsJson = await ApiService.getWithToken(ApiConst.getAllTopics, {});
      log("topics $topicsJson");
      if (topicsJson != null) {
        return topicWFromJson(topicsJson);
      } else {
        log("API response is null");
        return null;
      }
    } catch (e, stacktrace) {
      log("Error fetching topics: $e");
      log("Stacktrace: $stacktrace");
      return null;
    }
  }

  static Future<List<StudentTask>?> getAllStatus() async {
    try {
      var topicsJson = await ApiService.getWithToken(ApiConst.getAllStatus, {});
      log("status $topicsJson");
      if (topicsJson != null) {
        return studentTaskFromJson(topicsJson);
      } else {
        log("API response is null");
        return null;
      }
    } catch (e, stacktrace) {
      log("Error fetching topics: $e");
      log("Stacktrace: $stacktrace");
      return null;
    }
  }

  static Future<Statistics?> getStats() async {
    try {
      var topicsJson = await ApiService.getWithToken(ApiConst.getStats, {});
      log("stats $topicsJson");
      if (topicsJson != null) {
        return statisticsFromJson(topicsJson);
      } else {
        log("API response is null");
        return null;
      }
    } catch (e, stacktrace) {
      log("Error fetching topics: $e");
      log("Stacktrace: $stacktrace");
      return null;
    }
  }
}
