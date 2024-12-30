import 'package:flutter/material.dart';
import 'package:presentation/extensions/brightness_extension.dart';

extension StatusColorExtension on ThemeMode {
  Brightness getStatusColor(BuildContext context) => switch (this) {
        ThemeMode.system => MediaQuery.of(context).platformBrightness.inverted,
        ThemeMode.light => Brightness.dark,
        ThemeMode.dark => Brightness.light,
      };
}
