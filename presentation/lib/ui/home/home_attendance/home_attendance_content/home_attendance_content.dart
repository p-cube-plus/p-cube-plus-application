import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/rounded_border.dart';

import 'home_attendance_content_data.dart';

class HomeAttendanceContent extends StatelessWidget {
  const HomeAttendanceContent(
    this.data, {
    super.key,
  });

  final HomeAttendanceContentData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RoundedBorder(
      padding: const EdgeInsets.only(top: 8),
      onTap: () => _navigateToAttendancePage(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Container(
            height: 7.0,
            width: 7.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.scheduleColor,
            ),
          ),
          Text(
            data.dateString,
            style: TextStyle(
              fontSize: 10,
              color: theme.neutral60,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data.titleString,
            style: TextStyle(
              fontSize: 12,
              color: theme.neutral100,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Expanded(child: SizedBox()),
          Icon(
            Icons.chevron_right,
            color: theme.neutral40,
            size: 24,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  _navigateToAttendancePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }
}
