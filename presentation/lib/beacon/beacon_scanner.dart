import 'dart:async';

import 'package:ibeacon_plugin/beacon_monitoring_state.dart';
import 'package:ibeacon_plugin/ibeacon_plugin.dart';
import 'package:ibeacon_plugin/region.dart';

class BeaconScanner {
  static final BeaconScanner _instance = BeaconScanner._internal();
  BeaconScanner._internal();
  factory BeaconScanner() => _instance;

  bool isBeaconDetected = false;
  final _plugin = IbeaconPlugin();

  StreamSubscription<BeaconMonitoringState>? _beaconListener;

  Future<void> startScanning(
      // String identifier,
      // String uuid,
      // int major,
      // int minor,
      ) async {
    await _plugin.setRegion(Region(
      identifier: "Pcube",
      uuid: "e2c56db5-dffb-48d2-b060-d0f5a71096e0",
      major: 40011,
      minor: 32023,
    ));

    _beaconListener = _plugin.monitoringStream.listen((data) {
      if (data == BeaconMonitoringState.inside) {
        isBeaconDetected = true;
      } else {
        isBeaconDetected = false;
      }
    });

    return _plugin.startMonitoring();
  }

  Future<void> stopScanning() async {
    await _plugin.stopMonitoring();
    await _beaconListener?.cancel();
  }
}
