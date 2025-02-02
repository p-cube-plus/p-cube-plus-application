import 'dart:async';

import 'package:domain/attendance/usecases/fetch_beacon_information_use_case.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:ibeacon_plugin/beacon_monitoring_state.dart';
import 'package:ibeacon_plugin/ibeacon_plugin.dart';
import 'package:ibeacon_plugin/region.dart';

class BeaconScanner {
  static final BeaconScanner _instance = BeaconScanner._internal();
  BeaconScanner._internal();
  factory BeaconScanner() => _instance;

  final _plugin = IBeaconPlugin();
  final _fetchBeaconInformationUseCase = FetchBeaconInformationUseCase();

  Future<bool> isBluetoothEnabled() => _plugin.isBluetoothEnabled;
  bool isBeaconDetected = false;

  bool _isStarting = false;
  StreamSubscription<BeaconMonitoringState>? _beaconListener;

  Future<void> startScanning() async {
    if (_isStarting) return;

    _isStarting = true;

    final beaconInfo = await _fetchBeaconInformationUseCase().getOrNull();
    if (beaconInfo == null) {
      _isStarting = false;
      return;
    }

    await _plugin.setRegion(Region(
      identifier: beaconInfo.identifier,
      uuid: beaconInfo.uuid,
      major: beaconInfo.major,
      minor: beaconInfo.minor,
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
