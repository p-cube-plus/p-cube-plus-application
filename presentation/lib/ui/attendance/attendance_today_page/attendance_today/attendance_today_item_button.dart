import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/date_time_extension.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_event.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/rounded_border.dart';

class AttendanceTodayItemButton extends StatelessWidget
    with ViewModel<AttendanceTodayViewmodel> {
  final TodayAttendance data;
  const AttendanceTodayItemButton(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (data.didAttend) {
      return RoundedBorder(
        color: _getBackgroundColor(theme),
        child: Column(
          children: [
            Text(
              _getText(),
              style: TextStyle(
                fontSize: 12,
                color: _getTextColor(theme),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              data.attendanceTime!.format("hh시 mm분 ss초"),
              style: TextStyle(
                fontSize: 12,
                color: theme.secondary120,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    } else {
      return watchWidget(
          (viewModel) => data.attendanceSequence == 1
              ? viewModel.isFirstAttendanceTime
              : viewModel.isSecondAttendanceTime, (isAttendanceTime) {
        return ElevatedButton(
          onPressed: _onClickAttendance(
            context,
            data.canAttend && isAttendanceTime,
          ),
          child: const Text(
            "출석하기",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        );
      });
    }
  }

  String _getText() {
    if (data.attendanceStatus == AttendanceStatusType.success) {
      return "출석 완료";
    } else if (data.attendanceStatus == AttendanceStatusType.late) {
      return "지각";
    } else {
      return "출석 실패";
    }
  }

  Color _getBackgroundColor(ThemeData theme) {
    if (data.attendanceStatus == AttendanceStatusType.success) {
      return theme.secondary20;
    } else {
      return theme.neutral10;
    }
  }

  Color _getTextColor(ThemeData theme) {
    if (data.attendanceStatus == AttendanceStatusType.success) {
      return theme.secondary120;
    } else {
      return theme.neutral40;
    }
  }

  Function()? _onClickAttendance(BuildContext context, bool canClick) {
    if (!canClick) return null;
    return () => read(context).triggerEvent(
          AttendanceTodayEventOnClickAttendance(data),
        );
  }
}
