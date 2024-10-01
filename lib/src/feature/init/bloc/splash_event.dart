import 'package:equatable/equatable.dart';

abstract class SplashPageEvent extends Equatable {
  const SplashPageEvent();

  @override
  List<Object> get props => [];
}


class ChangeCurrentLanguage extends SplashPageEvent {
  final String newLanguage;

  const ChangeCurrentLanguage(this.newLanguage);

  @override
  List<Object> get props => [newLanguage];
}
