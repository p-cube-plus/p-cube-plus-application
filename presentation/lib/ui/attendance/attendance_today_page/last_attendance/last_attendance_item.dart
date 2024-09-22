import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/date_time_extension.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/attendance_status_image.dart';

class LastAttendanceItem extends StatelessWidget {
  final RecentAttendance data;
  const LastAttendanceItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          data.date.format("M월 d일"),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
        ),
        const SizedBox(height: 8),
        AttendanceStatusImage(data.type),
      ],
    );
  }
}
