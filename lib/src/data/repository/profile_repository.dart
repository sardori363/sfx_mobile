import 'dart:convert';
import 'dart:developer';

import 'package:sfx/src/common/server/api/api.dart';
import 'package:sfx/src/common/server/api/api_constants.dart';

class ProfileRepository {
  static Future<Map<String, dynamic>?> getCurrentProfileData() async {
    log("profile repo");
    try {
      var profileData =
          await ApiService.getWithToken(ApiConst.getCurrentUserData, {});
      log(jsonEncode(profileData));
      log("profile repo");
      return jsonDecode(profileData!);
    } catch (e) {
      log("$e");
      return null;
    }
  }
}
