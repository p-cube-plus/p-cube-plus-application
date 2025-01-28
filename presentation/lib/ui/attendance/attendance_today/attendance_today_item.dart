import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today/attendance_today_item_button.dart';
import 'package:presentation/ui/attendance/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/attendance_status_image.dart';

import 'attendance_today_item_time_text.dart';

class AttendanceTodayItem extends StatelessWidget
    with ViewModel<AttendanceTodayViewmodel> {
  final TodayAttendance data;
  const AttendanceTodayItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              "${data.attendanceSequence}차 인증",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: theme.neutral40,
              ),
            ),
            const SizedBox(width: 8),
            AttendanceTodayItemTimeText(data.startTime, data.endTime),
          ],
        ),
        const SizedBox(height: 8),
        watchWidget(
          (viewModel) => viewModel.shouldRefresh,
          (context, shouldRefresh) {
            read(context).shouldRefresh = false;
            return Row(
              children: [
                AttendanceStatusImage(data.attendanceStatus),
                const SizedBox(width: 24),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: AttendanceTodayItemButton(data),
                  ),
                ),
              ],
            );
          },
          shouldRebuild: (previous, next) {
            return next == true;
          },
        ),
      ],
    );
  }
}
