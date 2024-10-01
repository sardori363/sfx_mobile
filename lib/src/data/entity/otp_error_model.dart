import 'dart:convert';

class OtpErrorModel {
  final String error;

  OtpErrorModel({
    required this.error,
  });

  factory OtpErrorModel.fromRawJson(String str) =>
      OtpErrorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpErrorModel.fromJson(Map<String, dynamic> json) => OtpErrorModel(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
