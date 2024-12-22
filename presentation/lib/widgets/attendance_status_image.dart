import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/widgets/status_icon/status_blank.dart';
import 'package:presentation/widgets/status_icon/status_fail.dart';
import 'package:presentation/widgets/status_icon/status_late.dart';
import 'package:presentation/widgets/status_icon/status_pending.dart';
import 'package:presentation/widgets/status_icon/status_success.dart';

class AttendanceStatusImage extends StatelessWidget {
  final AttendanceStatusType type;
  final double width;
  final double height;

  const AttendanceStatusImage(
    this.type, {
    super.key,
    this.width = 68,
    this.height = 68,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AttendanceStatusType.blank => StatusBlank(size: 48),
      AttendanceStatusType.success => StatusSuccess(size: 48),
      AttendanceStatusType.failed => StatusFail(size: 48),
      AttendanceStatusType.late => StatusLate(size: 48),
      AttendanceStatusType.pending => StatusPending(size: 48),
    };
  }
}
