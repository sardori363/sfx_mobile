import 'dart:convert';

import 'package:sfx/src/data/entity/task_model.dart';

List<Topic> topicFromJson(String str) => List<Topic>.from(jsonDecode(str).map((item) => Topic.fromJson(item)));
String topicToJson(List<Topic> data) => jsonEncode(List<dynamic>.from(data.map((item) => item.toJson())));

class Topic {
  final int id;
  final String name;
  final String description;
  final List<Task> tasks;

  Topic({
    required this.id,
    required this.name,
    required this.description,
    required this.tasks,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      tasks: List<Task>.from(json['tasks'].map((item) => Task.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tasks': List<dynamic>.from(tasks.map((item) => item.toJson())),
    };
  }
}
