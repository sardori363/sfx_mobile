import 'package:equatable/equatable.dart';

enum ProfilePageState { init, loading, userRegistered, userNotRegistered, lightModeSet}

class ProfileState extends Equatable {
  final ProfilePageState pageState;
  final Map<String, dynamic> profileData;
  final bool? isLightMode;

  const ProfileState({
    required this.pageState,
    required this.profileData,
    this.isLightMode,
  });

  ProfileState copyWith({
    ProfilePageState? pageState,
    Map<String, dynamic>? profileData,
    bool? isLightMode
  }) {
    return ProfileState(
        pageState: pageState ?? this.pageState,
        profileData: profileData ?? this.profileData,
      isLightMode: isLightMode ?? this.isLightMode,
    );
  }

  @override
  List<Object?> get props => [pageState, profileData, isLightMode];
}