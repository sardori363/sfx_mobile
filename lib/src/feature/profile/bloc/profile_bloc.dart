import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfx/src/data/repository/profile_repository.dart';
import '../../../common/local/app_storage.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'dart:ui' as ui;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(const ProfileState(
            isLightMode: true,
            pageState: ProfilePageState.userNotRegistered,
            profileData: {})) {
    on<SetLightMode>(_onSetLightMode);
    on<GetProfileDataEvent>(_onGetProfileData);
    _loadInitialTheme();
  }

  Future<void> _loadInitialTheme() async {
    // Read the stored theme value as a string and convert it to a bool
    final String? theme = await AppStorage.$read(key: StorageKey.theme);

    bool isLight = ui.window.platformBrightness != ui.Brightness.dark;

    final bool isLightMode =
        (theme == null) ? isLight : theme.toLowerCase() == 'true';

    emit(ProfileState(
        isLightMode: isLightMode,
        pageState: ProfilePageState.lightModeSet,
        profileData: {}));
  }

  void _onSetLightMode(SetLightMode event, Emitter<ProfileState> emit) async {
    // Save the theme preference as a string in AppStorage
    await AppStorage.$write(
        key: StorageKey.theme, value: event.isLightMode.toString());

    emit(state.copyWith(
        isLightMode: event.isLightMode,
        pageState: ProfilePageState.lightModeSet));
  }

  Future<void> _onGetProfileData(
    GetProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    log("profile bloc");

    var token = await AppStorage.$read(key: StorageKey.accessToken);

    if (token == null) {
      emit(const ProfileState(
          pageState: ProfilePageState.userNotRegistered, profileData: {}));
    }

    emit(const ProfileState(
        pageState: ProfilePageState.loading, profileData: {}));

    var result = await ProfileRepository.getCurrentProfileData();

    if (result != null) {
      log("profileData is not null");
      emit(ProfileState(
          profileData: result, pageState: ProfilePageState.userRegistered));
    } else {
      log("profile bloc get data error");
      emit(const ProfileState(
          profileData: {}, pageState: ProfilePageState.userNotRegistered));
    }
  }

  void _onLogOut() {}
}
