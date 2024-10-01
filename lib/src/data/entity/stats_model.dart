import 'dart:convert';

Statistics statisticsFromJson(String str) => Statistics.fromJson(jsonDecode(str));
String statisticsToJson(Statistics data) => jsonEncode(data.toJson());

class Statistics {
  final String student;
  final int allTasks;
  final int completedTasks;

  Statistics({
    required this.student,
    required this.allTasks,
    required this.completedTasks,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      student: json['student'],
      allTasks: json['all_tasks'],
      completedTasks: json['completed_tasks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student': student,
      'all_tasks': allTasks,
      'completed_tasks': completedTasks,
    };
  }
}
