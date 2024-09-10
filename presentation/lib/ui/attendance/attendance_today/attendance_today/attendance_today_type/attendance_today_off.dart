import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/attendance/attendance_today/attendance_today_viewmodel.dart';

import '../../attendance_today_event.dart';

class AttendanceTodayOff extends StatelessWidget
    with ViewModel<AttendanceTodayViewmodel> {
  final int attendanceCount;
  const AttendanceTodayOff(this.attendanceCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => read(context)
              .triggerEvent(AttendanceTodayEventOnClickAttendance(attendanceCount)),
          child: const Text(
            "출석하기",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
