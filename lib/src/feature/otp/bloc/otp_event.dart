part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OpenTelegramLinkEvent extends OtpEvent {}

class OtpSubmitted extends OtpEvent {
  final String otp;

  const OtpSubmitted(this.otp);

  @override
  List<Object> get props => [otp];
}