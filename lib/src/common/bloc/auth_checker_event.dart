abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class AuthChanged extends AuthEvent {
  final bool isRegistered;

  const AuthChanged({required this.isRegistered});

  @override
  List<Object> get props => [isRegistered];
}
