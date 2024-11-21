import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ExecutiveAttendancePage extends StatelessWidget {
  const ExecutiveAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: const DefaultAppBar(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "출석",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
          const SizedBox(height: 20),
          _AttendanceSettingTile(
            titleName: "정기회의 출석",
            onClick: () => _navigateToRegularMettingSettingPage(context),
          ),
          _AttendanceSettingTile(
            titleName: "파트회의 출석",
            onClick: () => _navigateToPartMettingSettingPage(context),
          ),
        ],
      ),
    );
  }

  void _navigateToRegularMettingSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegularMettingSettingPage(),
      ),
    );
  }

  void _navigateToPartMettingSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }
}

class _AttendanceSettingTile extends StatelessWidget {
  final String titleName;
  final Function() onClick;
  const _AttendanceSettingTile({
    required this.titleName,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RoundedBorder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      onTap: () => onClick.call(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: TextStyle(
              fontSize: 14,
              color: theme.neutral100,
              fontWeight: FontWeight.w700,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: theme.neutral40,
            size: 24,
          ),
        ],
      ),
    );
  }
}
