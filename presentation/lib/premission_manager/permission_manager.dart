import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final PermissionManager _instance = PermissionManager._internal();
  PermissionManager._internal();
  factory PermissionManager() => _instance;

  Future<void> checkOnBoardingPermission() async {
    await checkNotificationPermission();
    await checkAttendancePermission();
  }

  Future<bool> checkAttendancePermission() async {
    // 블루투스의 위치 정보를 얻기 위해 사용
    var isGrantedLocationWhenInUse = true;
    if (!(await Permission.locationWhenInUse.isGranted)) {
      isGrantedLocationWhenInUse =
          await Permission.locationWhenInUse.request().isGranted;
    }

    // 블루투스 모듈에 접근 권한
    var isGrantedBluetooth = true;
    if (!(await Permission.bluetooth.isGranted)) {
      isGrantedBluetooth = await Permission.bluetooth.request().isGranted;
    }

    // 주변 블루투스 검색 권한
    var isGrantedBluetoothConnect = true;
    if (!(await Permission.bluetoothConnect.isGranted)) {
      isGrantedBluetoothConnect =
          await Permission.bluetoothConnect.request().isGranted;
    }

    // 블루투스 스캔 가능 권한
    var isGrantedBluetoothScan = true;
    if (!(await Permission.bluetoothScan.isGranted)) {
      isGrantedBluetoothScan =
          await Permission.bluetoothScan.request().isGranted;
    }

    return isGrantedLocationWhenInUse &&
        isGrantedBluetooth &&
        isGrantedBluetoothConnect &&
        isGrantedBluetoothScan;
  }

  Future<void> checkNotificationPermission() async {
    // 알림 권한 확인
    if (!(await Permission.notification.isGranted)) {
      await Permission.notification.request();
    }
  }
}
