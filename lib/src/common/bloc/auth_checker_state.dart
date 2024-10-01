abstract class AuthState {
  const AuthState();

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthUnRegistered extends AuthState {}