import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfx/src/feature/init/bloc/splash_event.dart';
import 'package:sfx/src/feature/init/bloc/splash_state.dart';

import '../../../common/local/app_storage.dart'; // Import this for SharedPreferences

class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState> {
  SplashPageBloc()
      : super(SplashPageState(currentLanguage: ' ')) {
    on<ChangeCurrentLanguage>((event, emit) {
      emit(state.copyWith(currentLanguage: event.newLanguage));
    });
    _loadInitialLanguage();
  }

  Future<void> _loadInitialLanguage() async {
    final String? storedLanguage =
        await AppStorage.$read(key: StorageKey.locale);
    final String initialLanguage = storedLanguage ?? 'uz';
    emit(state.copyWith(currentLanguage: initialLanguage));
  }
}
