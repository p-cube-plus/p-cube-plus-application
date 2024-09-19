import 'package:data/common/memory_cache.dart';
import 'package:data/remote/p_cube_api/home/home_remote_datasource.dart';
import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:get_it/get_it.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final homeRemoteDatasource = GetIt.I.get<HomeRemoteDatasource>();

  @override
  Future<TodayAttendance> attend(
      int id, int sequenceNumber, DateTime currentTime) {
    // TODO: implement attend
    throw UnimplementedError();
  }

  @override
  Future<List<AttendanceStatusType>> getAttendanceStatusInMonth(
      AttendanceType attendanceType, int year, int month) {
    // TODO: implement getAttendanceStatusInMonth
    throw UnimplementedError();
  }

  final MemoryCache<List<HomeAttendance>> _homeAttendanceCache = MemoryCache(
    Duration(hours: 2),
  );

  @override
  Future<List<HomeAttendance>> getHomeAttendanceList() {
    homeRemoteDatasource.getHomeAttendance();
    _homeAttendanceCache.get();
  }

  @override
  Future<List<MemberAttendanceState>> getMemberAttendanceStateList(
      AttendanceType attendanceType, DateTime searchDate) {
    // TODO: implement getMemberAttendanceStateList
    throw UnimplementedError();
  }

  @override
  Future<List<AttendanceStatusType>> getRecentAttendanceStatus(int count) {
    // TODO: implement getRecentAttendanceStatus
    throw UnimplementedError();
  }

  @override
  Future<List<TodayAttendance>> getTodayAttendanceList() {
    // TODO: implement getTodayAttendanceList
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
  Future<List<AttendanceData>> getAttendanceExistDayListInMonth(
      AttendanceType attendanceType, int year, int month) {
    // TODO: implement getAttendanceExistDayListInMonth
    throw UnimplementedError();
  }
}
