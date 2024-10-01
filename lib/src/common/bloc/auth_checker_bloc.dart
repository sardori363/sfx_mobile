import 'package:bloc/bloc.dart';
import 'package:sfx/src/common/bloc/auth_checker_event.dart';
import 'package:sfx/src/common/bloc/auth_checker_state.dart';

class AuthCheckerBloc extends Bloc<AuthEvent, AuthState> {
  AuthCheckerBloc() : super(AuthInitial()) {
    on<AuthChanged>((event, emit) {
      if (event.isRegistered) {
        emit(AuthRegistered());
      } else {
        emit(AuthUnRegistered());
      }
    });
    add(const AuthChanged(isRegistered: false));
  }
}
