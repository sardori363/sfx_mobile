import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(jsonDecode(str).map((item) => Task.fromJson(item)));
String taskToJson(List<Task> data) => jsonEncode(List<dynamic>.from(data.map((item) => item.toJson())));

class Task {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int topic;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.topic,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': imageUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'topic': topic,
    };
  }
}

List<TaskWStatus> taskWStatusFromJson(String str) => List<TaskWStatus>.from(jsonDecode(str).map((item) => TaskWStatus.fromJson(item)));
String taskWStatusToJson(List<TaskWStatus> data) => jsonEncode(List<dynamic>.from(data.map((item) => item.toJson())));

class TaskWStatus {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? status; // Can be null

  TaskWStatus({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.status, // Nullable status
  });

  factory TaskWStatus.fromJson(Map<String, dynamic> json) {
    return TaskWStatus(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'], // Can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': imageUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status, // Nullable status
    };
  }
}
