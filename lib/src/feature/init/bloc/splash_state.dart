class SplashPageState {
  final String currentLanguage;

  SplashPageState({
    required this.currentLanguage,
  });

  SplashPageState copyWith({
    String? currentLanguage,
  }) {
    return SplashPageState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}
