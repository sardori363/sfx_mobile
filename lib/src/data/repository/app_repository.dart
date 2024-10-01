import '../entity/otp_model.dart';

abstract class AppRepository {
  Future<OtpModel?> verifyKey({required String key});
}
