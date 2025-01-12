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
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }

    // 블루투스 모듈에 접근 권한
    status = await Permission.bluetooth.status;
    if (!status.isGranted) {
      await Permission.bluetooth.request();
    }

    // 주변 블루투스 검색 권한
    status = await Permission.bluetoothConnect.status;
    if (!status.isGranted) {
      await Permission.bluetoothConnect.request();
    }

    // 블루투스 스캔 가능 권한
    status = await Permission.bluetoothScan.status;
    if (!status.isGranted) {
      await Permission.bluetoothScan.request();
    }

    return Future.wait([
      Permission.location.status,
      Permission.bluetooth.status,
      Permission.bluetoothConnect.status,
      Permission.bluetoothScan.status,
    ]).then((permissionList) =>
        permissionList
            .where((permission) => !permission.isGranted)
            .firstOrNull ==
        null);
  }

  Future<void> checkNotificationPermission() async {
    // 알림 권한 확인
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
}
