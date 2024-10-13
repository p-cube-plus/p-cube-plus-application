import 'package:domain/attendance/value_objects/attendance_check.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';

abstract interface class AttendanceRepository {
  Future<List<HomeAttendance>> getHomeAttendanceList();

  /// 해당 월의 주 개수만큼 리스트 개수 반환. (달의 최대가 4주면 개수는 4개)
  Future<List<AttendanceStatusType>> getAttendanceStatusInMonth(
    AttendanceType attendanceType,
    int year,
    int month,
  );

  Future<List<TodayAttendance>> getTodayAttendanceList(
      AttendanceData attendanceData);

  Future<List<RecentAttendance>> getRecentAttendanceStatus(
    AttendanceType type,
    int count,
  );

  bool getBeaconDetected();
  void startScanningBeacon();
  Future<void> stopScanningBeacon();

  Future<AttendanceCheck?> getLocalAttendanceData(int id);
  Future<void> insertAttendanceData(AttendanceCheck data);

  //
  // 아래부터는 임원진 데이터
  //

  Future<List<MemberAttendanceState>> getMemberAttendanceStateList(
    AttendanceType attendanceType,
    DateTime searchDate,
  );

  Future<List<AttendanceData>> getAttendanceExistDayListInMonth(
    AttendanceType attendanceType,
    int year,
    int month,
  );

  Future<void> updateAttendance(
    int attendanceId,
    DateTime startTime,
    DateTime endTime,
  );

  Future<void> setAttendance(
    int attendanceId,
    int memberId,
    AttendanceStatusType newStatus,
    DateTime firstCheckedTime,
    DateTime? secondCheckedTime,
  );
}
