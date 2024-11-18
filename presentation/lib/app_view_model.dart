import 'package:domain/app_configuration/usecases/fetch_theme_type_use_case.dart';
import 'package:domain/app_configuration/usecases/update_theme_type_use_case.dart';
import 'package:domain/app_configuration/value_objects/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/base_viewmodel.dart';

class AppViewModel extends BaseViewModel<void, void> {
  final _fetchThemeTypeUseCase = FetchThemeTypeUseCase();
  final _updateThemeTypeUseCase = UpdateThemeTypeUseCase();

  late ThemeMode currentThemeMode = _fetchThemeType();

  ThemeMode _fetchThemeType() {
    try {
      final themeType = _fetchThemeTypeUseCase();
      return switch (themeType) {
        ThemeType.system => ThemeMode.system,
        ThemeType.light => ThemeMode.light,
        ThemeType.dark => ThemeMode.dark,
      };
    } catch (_) {
      return ThemeMode.system;
    }
  }

  void updateThemeType(ThemeType type) {
    _updateThemeTypeUseCase.call(type);
    currentThemeMode = _fetchThemeType();
    notifyListeners();
  }
}
