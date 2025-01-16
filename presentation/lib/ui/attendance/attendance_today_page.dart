import 'dart:async';

import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/beacon/beacon_scanner.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/premission_manager/permission_manager.dart';
import 'package:presentation/ui/attendance/attendance_today_state.dart';
import 'package:presentation/ui/attendance/attendance_today_viewmodel.dart';
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
    with ViewModel<AttendanceTodayViewmodel>, WidgetsBindingObserver {
  bool _isCheckingPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() => _checkPermission());
    Future.microtask(() => _setStateListener());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_isCheckingPermission) return;
      Future.microtask(() => _checkPermission());
    }
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
      ),
    );
  }

  void _checkPermission() async {
    _isCheckingPermission = true;
    final isAvailablePermission =
        await PermissionManager().checkAttendancePermission();
    if (!isAvailablePermission) {
      _showUnavailablePermissionDialog();
      return;
    }

    final isBluetoothEnabled = await BeaconScanner().isBluetoothEnabled();
    if (!isBluetoothEnabled) {
      _showRequestBluetoothDialog();
      return;
    }
  }

  void _showFailedDialog() {
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

  void _showUnavailablePermissionDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: DefaultAlert(
            title: "출석에 필요한 권한이 없습니다.",
            description: "근처 기기 검색과 블루투스 권한을 허용해주세요.",
            messageType: MessageType.ok,
            onTapOk: () {
              Navigator.pop(dialogContext);
              openAppSettings();
              _isCheckingPermission = false;
            },
          ),
        );
      },
    );
  }

  void _showRequestBluetoothDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: DefaultAlert(
            title: "블루투스가 꺼져있습니다.",
            description: "블루투스를 켜주세요.",
            messageType: MessageType.ok,
            onTapOk: () async {
              final isBluetoothEnabled =
                  await BeaconScanner().isBluetoothEnabled();
              if (!isBluetoothEnabled) {
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
                return;
              }

              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext);
              BeaconScanner().startScanning().getOrNull();
            },
          ),
        );
      },
    );
  }
}
