import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sfx/src/data/entity/otp_model.dart';

import '../../common/server/api/api.dart';
import '../../common/server/api/api_constants.dart';
import 'app_repository.dart';

@immutable
class AppRepositoryImpl implements AppRepository {
  factory AppRepositoryImpl() => _impl;

  const AppRepositoryImpl._internal();

  static const AppRepositoryImpl _impl = AppRepositoryImpl._internal();

  @override
  Future<OtpModel?> verifyKey({required String key}) async {
    try {
      final String? response = await ApiService.postWithoutManualHeader(
        ApiConst.verifyApi,
        <String, dynamic>{"otp_key": key},
      );
      if (response != null) {
        return otpModelFromJson(response);
      }
      return null;
    } catch (e) {
      debugPrint('Error verifying OTP key $e');
      return null;
    }
  }
}
