import 'dart:convert';

List<TopicW> topicWFromJson(String str) => List<TopicW>.from(jsonDecode(str).map((item) => TopicW.fromJson(item)));
String topicWToJson(List<TopicW> data) => jsonEncode(List<dynamic>.from(data.map((item) => item.toJson())));

class TopicW {
  final int id;
  final String name;
  final String description;

  TopicW({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TopicW.fromJson(Map<String, dynamic> json) {
    return TopicW(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
