import 'dart:convert';

List<StudentTaskImage> studentTaskImageFromJson(String str) =>
    List<StudentTaskImage>.from(jsonDecode(str).map((item) => StudentTaskImage.fromJson(item)));

String studentTaskImageToJson(List<StudentTaskImage> data) =>
    jsonEncode(List<dynamic>.from(data.map((item) => item.toJson())));

class StudentTaskImage {
  final int id;
  final List<ImageData> images;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int student;
  final int task;

  StudentTaskImage({
    required this.id,
    required this.images,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.task,
  });

  factory StudentTaskImage.fromJson(Map<String, dynamic> json) {
    return StudentTaskImage(
      id: json['id'],
      images: List<ImageData>.from(json['images'].map((item) => ImageData.fromJson(item))),
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
      'images': List<dynamic>.from(images.map((item) => item.toJson())),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'student': student,
      'task': task,
    };
  }
}

class ImageData {
  final int id;
  final String imageUrl;
  final DateTime uploadedAt;
  final int studentTask;

  ImageData({
    required this.id,
    required this.imageUrl,
    required this.uploadedAt,
    required this.studentTask,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      imageUrl: json['image'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
      studentTask: json['student_task'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageUrl,
      'uploaded_at': uploadedAt.toIso8601String(),
      'student_task': studentTask,
    };
  }
}
