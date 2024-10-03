import 'dart:async';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:permission_handler/permission_handler.dart';

class BeaconScanner {
  bool isBeaconDetected = false;
  StreamSubscription<MonitoringResult>? _streamMonitoring;

  Future<void> initialize() async {
    await flutterBeacon.initializeAndCheckScanning;
  }

  Future<void> startScanning(
    String identifier,
    String uuid,
    int major,
    int minor,
  ) async {
    final regions = <Region>[
      Region(
        identifier: identifier,
        proximityUUID: uuid,
        major: major,
        minor: minor,
      ),
    ];

    _streamMonitoring?.cancel();
    _streamMonitoring =
        flutterBeacon.monitoring(regions).listen((MonitoringResult result) {
      isBeaconDetected = result.monitoringState == MonitoringState.inside;
    });
  }

  Future<void> stopScanning() async {
    _streamMonitoring?.cancel();
  }

  Future<void> initPlatformState() async {
    // 블루투스의 위치 정보를 얻기 위해 사용
    var status = await Permission.location.status;
    if (!(status.isGranted)) {
      await Permission.location.request();
    }

    // 블루투스 모듈에 접근 권한
    status = await Permission.bluetooth.status;
    if (!(status.isGranted)) {
      await Permission.bluetooth.request();
    }

    // 주변 블루투스 검색 권한
    status = await Permission.bluetoothScan.status;
    if (!(status.isGranted)) {
      await Permission.bluetoothScan.request();
    }
  }
}
