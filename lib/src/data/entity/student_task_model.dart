import 'dart:convert';

List<StudentTask> studentTaskFromJson(String str) => List<StudentTask>.from(jsonDecode(str).map((item) => StudentTask.fromJson(item)));
String studentTaskToJson(List<StudentTask> data) => jsonEncode(List<dynamic>.from(data.map((item) => item.toJson())));

class StudentTask {
  final int id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int student;
  final int task;

  StudentTask({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.task,
  });

  factory StudentTask.fromJson(Map<String, dynamic> json) {
    return StudentTask(
      id: json['id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      student: json['student'],
      task: json['task'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'student': student,
      'task': task,
    };
  }
}