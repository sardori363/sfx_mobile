import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../local/app_storage.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('uz', 'UZ')) {
    loadLocale();
  }

  Future<void> loadLocale() async {
    final savedLocaleCode = await AppStorage.$read(key: StorageKey.locale);
    if (savedLocaleCode != null) {
      emit(Locale(savedLocaleCode));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    await AppStorage.$write(key: StorageKey.locale, value: locale.languageCode);
    emit(locale);
  }
}
