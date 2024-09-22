import 'dart:math';

import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:domain/common/value_objects/color.dart';
import 'package:domain/member/value_objects/member_part_type.dart';

class MockAttendanceRepositoryImpl implements AttendanceRepository {
  @override
  Future<TodayAttendance> attend(
      int id, int sequenceNumber, DateTime currentTime) {
    // TODO: implement attend
    throw UnimplementedError();
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
    await Future.delayed(Duration(seconds: Random.secure().nextInt(5)));
    return [
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 1,
          attendanceDate: DateTime.now(),
          type: RegularMetting(),
        ),
        scheduleTypeColor: Color(0xE55542),
        title: '판도라큐브 정기회의',
      ),
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 2,
          attendanceDate: DateTime.now(),
          type: PartMettingAttendance(MemberPartType.development),
        ),
        scheduleTypeColor: Color(0xE55542),
        title: '프로그래밍 파트회의',
      ),
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 3,
          attendanceDate: DateTime.now(),
          type: PartMettingAttendance(MemberPartType.art),
        ),
        scheduleTypeColor: Color(0xE55542),
        title: '아트 파트회의',
      ),
      HomeAttendance(
        attendanceData: AttendanceData(
          id: 4,
          attendanceDate: DateTime.now(),
          type: PartMettingAttendance(MemberPartType.design),
        ),
        scheduleTypeColor: Color(0xE55542),
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
          attendance: AttendanceData(
              id: id, attendanceDate: attendanceDate, type: type),
          sequenceNumber: 1),
      TodayAttendance(attendance: null, sequenceNumber: 2),
    ]);
  }

  @override
  Future<List<RecentAttendance>> getRecentAttendanceStatus(
      AttendanceType type, int count) {
    // TODO: implement getRecentAttendanceStatus
    throw UnimplementedError();
  }
}
