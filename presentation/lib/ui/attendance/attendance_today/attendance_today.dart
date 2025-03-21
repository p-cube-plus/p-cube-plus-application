import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

import 'attendance_today_item.dart';

class AttendanceToday extends StatelessWidget
    with ViewModel<AttendanceTodayViewmodel> {
  const AttendanceToday({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final attendanceTypeName = read(context).selectedAttendance.type.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        DefaultFutureBuilder(
          fetchData: read(context).fetchStateData(),
          showOnLoadedWidget: (context, todayAttendanceList) {
            read(context).startCheckCanAttendanceTimer(todayAttendanceList);
            return RoundedBorder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    read(context)
                        .selectedAttendance
                        .attendanceDate
                        .format("M월 d일 $attendanceTypeName회의"),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AttendanceTodayItem(todayAttendanceList[0]),
                  const SizedBox(height: 28),
                  Divider(
                    thickness: 1,
                    color: theme.neutral10,
                  ),
                  const SizedBox(height: 24),
                  AttendanceTodayItem(todayAttendanceList[1]),
                ],
              ),
            );
          },
          showOnLoadingWidget: (context) {
            return RoundedBorder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Column(
                children: [
                  SkeletonAnimation(160, 16, radius: 50),
                  const SizedBox(height: 16),
                  SkeletonAnimation(280, 82, radius: 10),
                  const SizedBox(height: 20),
                  Divider(
                    thickness: 1,
                    color: theme.neutral10,
                  ),
                  const SizedBox(height: 16),
                  SkeletonAnimation(280, 82, radius: 10),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
