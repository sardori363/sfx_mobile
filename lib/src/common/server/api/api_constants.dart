final class ApiConst {
  const ApiConst._();

  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);

  static const String baseUrl = "http://5.161.76.131/";

  // Courses api
  static const String getAllTasksByTopicId = "en/tasks/topics/4/tasks";
  static const String getAllTopics = "en/tasks/topics";

  static const String verifyApi = "en/otp/verify/";

  static const String getStats = "en/tasks/count-status/";

  static const String getCurrentUserData = "en/users/user_info";

  static const String getAllStatus = "en/tasks/student-tasks/";

  static const String postTask = "en/tasks/student-tasks/submit/";

  static const String refreshToken = "en/otp/token/refresh/";
}

final class ApiParams {
  const ApiParams._();

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};

  static Map<String, dynamic> cabinetSmsCheckParams(
          {required String phone, required String code}) =>
      <String, dynamic>{
        "phone": phone,
        "code": code,
      };
}
