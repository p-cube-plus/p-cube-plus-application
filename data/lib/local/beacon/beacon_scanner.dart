import 'dart:async';

import 'package:ibeacon_plugin/beacon_monitoring_state.dart';
import 'package:ibeacon_plugin/ibeacon_plugin.dart';
import 'package:ibeacon_plugin/region.dart';
import 'package:permission_handler/permission_handler.dart';

class BeaconScanner {
  bool isBeaconDetected = false;
  final plugin = IbeaconPlugin();

  StreamSubscription<BeaconMonitoringState>? _beaconListener;

  Future<void> initialize() async {}

  Future<void> startScanning(
    String identifier,
    String uuid,
    int major,
    int minor,
  ) async {
    await plugin.setRegion(Region(
      identifier: identifier,
      uuid: uuid,
      major: major,
      minor: minor,
    ));

    _beaconListener = plugin.monitoringStream.listen((data) {
      if (data == BeaconMonitoringState.inside) {
        isBeaconDetected = true;
      } else {
        isBeaconDetected = false;
      }
    });

    return plugin.startMonitoring();
  }

  Future<void> stopScanning() async {
    await plugin.stopMonitoring();
    await _beaconListener?.cancel();
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
