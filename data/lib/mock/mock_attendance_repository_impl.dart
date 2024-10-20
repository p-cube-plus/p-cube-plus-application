import 'package:data/local/beacon/beacon_scanner.dart';
import 'package:data/local/local_db/attendance/attendance_dao.dart';
import 'package:data/local/local_db/attendance/attendance_local_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/attendance_remote_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/body/update_attendance_body_dto.dart';
import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_check.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:get_it/get_it.dart';

class MockAttendanceRepositoryImpl implements AttendanceRepository {
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
  Future<List<HomeAttendance>> getHomeAttendanceList() async {
    //await Future.delayed(Duration(seconds: Random.secure().nextInt(5)));
    return [
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 1,
          attendanceDate: DateTime.now(),
          type: RegularMetting(),
        ),
        scheduleType: ScheduleTypMain(),
        title: '판도라큐브 정기회의',
      ),
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 2,
          attendanceDate: DateTime.now(),
          type: PartMettingAttendance(MemberPartType.development),
        ),
        scheduleType: ScheduleTypMain(),
        title: '프로그래밍 파트회의',
      ),
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 3,
          attendanceDate: DateTime.now(),
          type: PartMettingAttendance(MemberPartType.art),
        ),
        scheduleType: ScheduleTypMain(),
        title: '아트 파트회의',
      ),
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 4,
          attendanceDate: DateTime.now(),
          type: PartMettingAttendance(MemberPartType.design),
        ),
        scheduleType: ScheduleTypMain(),
        title: '디자인 파트회의',
      ),
    ];
  }

  @override
  Future<List<MemberAttendanceState>> getMemberAttendanceStateList(
      AttendanceType attendanceType, DateTime searchDate) {
    // TODO: implement getMemberAttendanceStateList
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
    return Future.value([
      TodayAttendance(
          id: 1,
          attendanceSequence: 1,
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(minutes: 10))),
      TodayAttendance(
          id: 2,
          attendanceSequence: 1,
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(minutes: 10))),
    ]);
  }

  @override
  Future<List<RecentAttendance>> getRecentAttendanceStatus(
      AttendanceType type, int count) {
    return Future.value([
      RecentAttendance(
        type: AttendanceStatusType.success,
        date: DateTime.now().subtract(Duration(days: 7)),
      ),
      RecentAttendance(
        type: AttendanceStatusType.failed,
        date: DateTime.now().subtract(Duration(days: 14)),
      ),
      RecentAttendance(
        type: AttendanceStatusType.late,
        date: DateTime.now().subtract(Duration(days: 21)),
      ),
      RecentAttendance(
        type: AttendanceStatusType.pending,
        date: DateTime.now().subtract(Duration(days: 28)),
      ),
    ]);
  }
}