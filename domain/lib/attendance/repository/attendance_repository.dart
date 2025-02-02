import 'package:domain/attendance/value_objects/attendance_check.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_summary.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/beacon_information.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';

abstract interface class AttendanceRepository {
  /// 오늘 출석 데이터 - 홈화면 출석체크
  Future<List<HomeAttendance>> getHomeAttendanceList();

  /// 오늘 출석 데이터 상세 - 오늘의 출석체크
  Future<List<TodayAttendance>> getTodayAttendanceList(
    AttendanceData attendanceData,
  );

  /// 해당 월의 주 개수만큼 출석 상태 반환. (달의 최대가 4주면 개수는 4개) - 오늘의 출석체크
  Future<List<AttendanceStatusType>> getAttendanceStatusInMonth(
    AttendanceType attendanceType,
    int year,
    int month,
  );

  Future<List<RecentAttendance>> getRecentAttendanceStatus(
    AttendanceType type,
    int count,
  );

  Future<AttendanceCheck?> getLocalAttendanceData(int id);
  Future<void> insertAttendanceData(AttendanceCheck data);

  Future<AttendanceSummary> getAttendanceSummaryList(
    AttendanceType type,
    int year,
    int month,
  );

  // DateTime이 null이면 화면에 첫 진입할 때 어떤 데이터 보여줄 지 결정
  Future<AttendanceDetailData> getAttendanceDetail(
    AttendanceType attendanceType,
    DateTime? searchDate,
  );

  Future<AttendanceDetailData> getNextAttendanceDetail(
    AttendanceType attendanceType,
    DateTime searchDate,
  );

  Future<AttendanceDetailData> getPreviousAttendanceDetail(
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

  Future<BeaconInformation> getBeaconInformation();
  Future<void> setBeaconInformation(BeaconInformation newData);
}
