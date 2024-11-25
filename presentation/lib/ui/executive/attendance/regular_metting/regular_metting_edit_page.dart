import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/attendance_status_tab/attendance_status_tab.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';

class RegularMettingEditPage extends StatelessWidget {
  const RegularMettingEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
      ),
      title: "정기회의 출석",
      backgroundColor: theme.primary80,
      content: AttendanceStatusTab(type: RegularMetting()),
    );
  }
}
