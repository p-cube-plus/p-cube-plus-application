import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/date_time_extension.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/list_divider.dart';
import 'package:presentation/widgets/rounded_border.dart';

import 'attendance_today_item.dart';

class AttendanceToday extends StatelessWidget
    with ViewModel<AttendanceTodayViewmodel> {
  const AttendanceToday({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "오늘의 출석체크",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: theme.neutral80,
          ),
        ),
        const SizedBox(height: 8),
        RoundedBorder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            children: [
              watchWidget(
                (viewModel) => viewModel.currentDate,
                (startDate) {
                  return Text(
                    startDate.format("M월 d일 정기회의"),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AttendanceTodayItem(read(context).firstAttendanceData),
              const SizedBox(height: 28),
              const ListDivider(horizontal: double.infinity, vertial: 1),
              const SizedBox(height: 24),
              AttendanceTodayItem(read(context).secondAttendanceData),
            ],
          ),
        ),
      ],
    );
  }
}
