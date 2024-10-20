import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_state.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today_viewmodel.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

import 'attendance_today/attendance_today.dart';
import 'last_attendance/last_attendance.dart';

class AttendanceTodayPage extends StatelessWidget {
  const AttendanceTodayPage({super.key, required this.selectedAttendance});
  final AttendanceData selectedAttendance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceTodayViewmodel(selectedAttendance),
      child: const _AttendanceTodayPage(),
    );
  }
}

class _AttendanceTodayPage extends StatefulWidget {
  const _AttendanceTodayPage();

  @override
  State<_AttendanceTodayPage> createState() => _AttendanceTodayPageState();
}

class _AttendanceTodayPageState extends State<_AttendanceTodayPage>
    with ViewModel<AttendanceTodayViewmodel> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setStateListener());
  }

  void _setStateListener() {
    read(context).eventStream.listen((event) {
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
        content: DefaultContent(
          child: Column(
            children: [
              SizedBox(height: 20),
              AttendanceToday(),
              SizedBox(height: 56),
              LastAttendance(),
            ],
          ),
        ));
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
