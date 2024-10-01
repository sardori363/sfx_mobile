import 'dart:convert';

OtpModel otpModelFromJson(String str) =>
    OtpModel.fromJson(json.decode(str) as Map<String, dynamic>);

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  final String refresh;
  final String access;

  OtpModel({
    required this.refresh,
    required this.access,
  });

  factory OtpModel.fromRawJson(String str) =>
      OtpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
