import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetLightMode extends ProfileEvent {
  final bool isLightMode;

  SetLightMode(this.isLightMode);

  @override
  List<Object> get props => [isLightMode];
}

class GetProfileDataEvent extends ProfileEvent{}
class LogOutEvent extends ProfileEvent{}