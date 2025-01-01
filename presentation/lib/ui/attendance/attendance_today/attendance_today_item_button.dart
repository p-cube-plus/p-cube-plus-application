import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/beacon/beacon_scanner.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/default_alert.dart';
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
              data.attendanceTime!.format("HH시 mm분 ss초"),
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
              ? viewModel.isPossibleFirstAttendance
              : viewModel.isPossibleSecondAttendance,
          (context, isAttendanceTime) {
        return ElevatedButton(
          onPressed: _onClickAttendance(
            context,
            isAttendanceTime,
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
    return () {
      if (!BeaconScanner().isBeaconDetected) {
        _showCanNotFoundBeaconDialog(context);
        return;
      }
      read(context).checkAttendance(data);
    };
  }

  void _showCanNotFoundBeaconDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DefaultAlert(
          title: "비콘을 찾을 수 없습니다.",
          description: "블루투스가 켜져있는지,\n또는 주변에 켜져있는 비콘이 있는지\n확인 후 다시 시도해주세요.",
          messageType: MessageType.ok,
          onTapOk: () {
            BeaconScanner().startScanning();
            Fluttertoast.showToast(msg: "비콘 모니터링을 재시작합니다.");
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
