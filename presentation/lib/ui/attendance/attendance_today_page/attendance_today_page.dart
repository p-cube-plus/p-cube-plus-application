import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_state.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';

import 'attendance_today/attendance_today.dart';
import 'last_attendance/last_attendance.dart';

class AttendanceTodayPage extends StatefulWidget {
  const AttendanceTodayPage({super.key});

  @override
  State<AttendanceTodayPage> createState() => _AttendanceTodayPageState();
}

class _AttendanceTodayPageState extends State<AttendanceTodayPage>
    with ViewModel<AttendanceTodayViewmodel> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setStateListener());
  }

  void _setStateListener() {
    read(context).uiEventStream.listen((event) {
      switch (event) {
        case AttendanceTodayState.showFailedDialog:
          _showFailedDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultPage(
      appbar: DefaultAppBar(),
      title: "출석체크",
      content: Column(
        children: [
          SizedBox(height: 20),
          AttendanceToday(),
          SizedBox(height: 56),
          LastAttendance(),
        ],
      ),
    );
  }

  _showFailedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const DefaultAlert(
          title: "출석체크에 실패했어요.",
          description: "다시 시도해주세요.",
          messageType: MessageType.ok,
        );
      },
    );
  }
}
