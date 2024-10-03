import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class HomeAttendanceContent extends StatelessWidget {
  const HomeAttendanceContent(
    this.data, {
    super.key,
  });

  final HomeAttendance data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RoundedBorder(
      height: 56,
      onTap: () => _navigateToAttendancePage(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Container(
            height: 7.0,
            width: 7.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(data.scheduleType.color.hex),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            data.attendanceData.attendanceDate.format("yyyy.MM.dd"),
            style: TextStyle(
              fontSize: 10,
              color: theme.neutral60,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data.title,
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
        builder: (context) => AttendanceTodayPage(
          selectedAttendance: data.attendanceData,
        ),
      ),
    );
  }
}
