import 'dart:async';

import 'package:ibeacon_plugin/beacon_monitoring_state.dart';
import 'package:ibeacon_plugin/ibeacon_plugin.dart';
import 'package:ibeacon_plugin/region.dart';

class BeaconScanner {
  static final BeaconScanner _instance = BeaconScanner._internal();
  BeaconScanner._internal();
  factory BeaconScanner() => _instance;

  final _plugin = IBeaconPlugin();

  Future<bool> isBluetoothEnabled() => _plugin.isBluetoothEnabled;
  bool isBeaconDetected = false;

  bool _isStarting = false;
  StreamSubscription<BeaconMonitoringState>? _beaconListener;

  Future<void> startScanning(
      // String identifier,
      // String uuid,
      // int major,
      // int minor,
      ) async {
    if (_isStarting) return;

    _isStarting = true;

    await _plugin.setRegion(Region(
      identifier: "Pcube",
      uuid: "e2c56db5-dffb-48d2-b060-d0f5a71096e0",
      major: 40011,
      minor: 32023,
    ));

    _beaconListener = _beaconListener ??
        _plugin.monitoringStream.listen(
          (data) {
            if (data == BeaconMonitoringState.inside) {
              isBeaconDetected = true;
            } else {
              isBeaconDetected = false;
            }
          },
        );

    return _plugin.startMonitoring().then((_) {
      _isStarting = false;
    }).onError((error, trace) {
      _isStarting = false;
    });
  }

  Future<void> stopScanning() async {
    isBeaconDetected = false;
    _isStarting = false;
    _beaconListener?.cancel();
    _beaconListener = null;
    await _plugin.stopMonitoring();
  }
}
