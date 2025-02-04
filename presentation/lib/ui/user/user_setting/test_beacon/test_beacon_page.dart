import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/beacon/beacon_scanner.dart';
import 'package:presentation/premission_manager/permission_manager.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';

class TestBeaconPage extends StatefulWidget {
  const TestBeaconPage({super.key});

  @override
  State<TestBeaconPage> createState() => _TestBeaconPageState();
}

class _TestBeaconPageState extends State<TestBeaconPage> {
  String startMonitoringText = "";
  String stopMonitoringText = "";
  String status = "비콘이 주변에 없습니다.";

  late Timer _timer;
  bool _previousState = false;

  @override
  void initState() {
    super.initState();

    checkPermission();
    startMonitoring();
  }

  void startMonitoring() {
    _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      var isBeaconDetected = BeaconScanner().isBeaconDetected;
      if (isBeaconDetected != _previousState) {
        _previousState = isBeaconDetected;
        setState(() {
          if (isBeaconDetected) {
            status = "비콘 감지";
          } else {
            status = "비콘이 주변에 없습니다.";
            stopMonitoringText = "성공";
            startMonitoringText = "";
          }
        });
      }
    });
  }

  void checkPermission() async {
    final isAvailablePermission =
        await PermissionManager().checkAttendancePermission();
    if (!isAvailablePermission) {
      _showUnavailablePermissionDialog();
      return;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (BeaconScanner().isBeaconDetected) {
      startMonitoringText = "감지중";
    }
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "비콘 모니터링 테스트",
      ),
      content: Column(
        children: [
          ElevatedButton(
              onPressed: () async => BeaconScanner()
                  .startScanning()
                  .then((value) => setState(() {
                        startMonitoringText = "감지중";
                        stopMonitoringText = "";
                      }))
                  .catchError((error) => setState(() {
                        startMonitoringText = error.toString();
                        stopMonitoringText = "";
                      })),
              child: const Text("모니터링 시작")),
          Text("모니터링 시작 상태"),
          Text(startMonitoringText),
          ElevatedButton(
              onPressed: () async => BeaconScanner()
                  .stopScanning()
                  .then((value) => setState(() {
                        stopMonitoringText = "성공";
                        startMonitoringText = "";
                        status = "비콘이 주변에 없습니다.";
                      }))
                  .catchError((error) => setState(() {
                        stopMonitoringText = error.toString();
                        startMonitoringText = "";
                      })),
              child: const Text("모니터링 중지")),
          Text("모니터링 중지 상태"),
          Text(stopMonitoringText),
          SizedBox(height: 16),
          Text("비콘 감지 상태"),
          Text(status),
        ],
      ),
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
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
