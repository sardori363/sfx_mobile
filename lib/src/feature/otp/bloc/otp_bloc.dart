import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sfx/src/data/repository/app_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/local/app_storage.dart';
import '../../../data/entity/otp_model.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OpenTelegramLinkEvent>(_onOpenTelegramLink);
  }

  Future<void> _onOpenTelegramLink(
    OpenTelegramLinkEvent event,
    Emitter<OtpState> emit,
  ) async {
    final Uri telegramUrl = Uri.parse('https://t.me/sfxtrading_bot');
    try {
      await launchUrl(telegramUrl);
      emit(OtpLinkOpenedSuccess());
    } catch (e) {
      debugPrint('Could not launch URL: $e');
      emit(OtpLinkOpenedFailure());
    }
  }

  Future<void> _onOtpSubmitted(
      OtpSubmitted event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    try {
      final isVerified = await AppRepositoryImpl().verifyKey(
        key: event.otp.toString(),
      );

      if (isVerified != null && isVerified is OtpModel) {
        emit(OtpVerified());
        await Future.delayed(const Duration(milliseconds: 500));
        final accessToken = isVerified.access;
        final refreshToken = isVerified.refresh;
        await AppStorage.$write(
          key: StorageKey.accessToken,
          value: accessToken,
        );
        await AppStorage.$write(
          key: StorageKey.refreshToken,
          value: refreshToken,
        );
      } else {
        // // Delay for 2 seconds before showing the error message
        // await Future.delayed(const Duration(seconds: 2));
        emit(const OtpError('Verification failed. Please try again.'));
      }
    } catch (e) {
      // Delay for 2 seconds before showing the error message
      // await Future.delayed(const Duration(seconds: 2));
      emit(OtpError(e.toString()));
    }
  }
}
