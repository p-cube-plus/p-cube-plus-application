import 'package:data/local/beacon/beacon_scanner.dart';
import 'package:data/local/local_db/attendance/attendance_dao.dart';
import 'package:data/local/local_db/attendance/attendance_local_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/attendance_remote_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/body/update_attendance_body_dto.dart';
import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_check.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_summary.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:get_it/get_it.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final beaconScanner = GetIt.I.get<BeaconScanner>();
  final attendanceRemoteDatasource = GetIt.I.get<AttendanceRemoteDatasource>();
  final attendanceLocalDatasource = GetIt.I.get<AttendanceLocalDatasource>();

  @override
  bool getBeaconDetected() {
    return beaconScanner.isBeaconDetected;
  }

  @override
  void startScanningBeacon() {
    beaconScanner.startScanning(
      "Pcube+",
      "e2c56db5-dffb-48d2-b060-d0f5a71096e0",
      40011,
      32023,
    );
  }

  @override
  Future<void> stopScanningBeacon() {
    return beaconScanner.stopScanning();
  }

  @override
  Future<AttendanceCheck?> getLocalAttendanceData(int id) async {
    final localData = await attendanceLocalDatasource.getAttendanceData(id);
    if (localData == null) return null;
    return AttendanceCheck(
      id: id,
      sequenceNumber: localData.sequenceNumber,
      attendanceCheckDateTime: localData.attendanceDateTime,
      status: localData.attendanceStatus,
    );
  }

  @override
  Future<void> insertAttendanceData(AttendanceCheck data) async {
    await attendanceLocalDatasource.insertAttendance(
      AttendanceDao(
        id: data.id,
        sequenceNumber: data.sequenceNumber,
        attendanceDateTime: data.attendanceCheckDateTime,
        attendanceStatus: data.status,
      ),
    );
    await attendanceRemoteDatasource.updateAttendance(
      data.id,
      UpdateAttendanceBodyDTO(
        state: data.status.toString(),
        firstAuthTIme: data.attendanceCheckDateTime.format("yyyyMMddhhmmss"),
      ),
    );
  }

  @override
  Future<List<AttendanceData>> getAttendanceExistDayListInMonth(
      AttendanceType attendanceType, int year, int month) {
    // TODO: implement getAttendanceExistDayListInMonth
    throw UnimplementedError();
  }

  @override
  Future<List<AttendanceStatusType>> getAttendanceStatusInMonth(
      AttendanceType attendanceType, int year, int month) {
    // TODO: implement getAttendanceStatusInMonth
    throw UnimplementedError();
  }

  @override
  Future<List<HomeAttendance>> getHomeAttendanceList() {
    // TODO: implement getHomeAttendanceList
    throw UnimplementedError();
  }

  @override
  Future<void> setAttendance(
      int attendanceId,
      int memberId,
      AttendanceStatusType newStatus,
      DateTime firstCheckedTime,
      DateTime? secondCheckedTime) {
    // TODO: implement setAttendance
    throw UnimplementedError();
  }

  @override
  Future<void> updateAttendance(
      int attendanceId, DateTime startTime, DateTime endTime) {
    // TODO: implement updateAttendance
    throw UnimplementedError();
  }

  @override
  Future<List<TodayAttendance>> getTodayAttendanceList(
      AttendanceData attendanceData) {
    // TODO: implement getTodayAttendanceList
    throw UnimplementedError();
  }

  @override
  Future<List<RecentAttendance>> getRecentAttendanceStatus(
      AttendanceType type, int count) {
    // TODO: implement getRecentAttendanceStatus
    throw UnimplementedError();
  }

  @override
  Future<AttendanceSummary> getAttendanceSummaryList(
      AttendanceType type, int year, int month) {
    // TODO: implement getAttendanceSummaryList
    throw UnimplementedError();
  }

  @override
  Future<AttendanceDetailData> getAttendanceDetail(
      AttendanceType attendanceType, DateTime? searchDate) {
    // TODO: implement getMemberAttendanceStateList
    throw UnimplementedError();
  }
}
