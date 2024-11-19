import 'package:data/common/memory_cache.dart';
import 'package:data/local/beacon/beacon_scanner.dart';
import 'package:data/local/local_db/attendance/attendance_dao.dart';
import 'package:data/local/local_db/attendance/attendance_local_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/attendance_remote_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/body/update_attendance_body_dto.dart';
import 'package:data/utils/mock_util.dart';
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
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_position_type.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:get_it/get_it.dart';

class MockAttendanceRepositoryImpl implements AttendanceRepository {
  final beaconScanner = GetIt.I.get<BeaconScanner>();
  final attendanceRemoteDatasource = GetIt.I.get<AttendanceRemoteDatasource>();
  final attendanceLocalDatasource = GetIt.I.get<AttendanceLocalDatasource>();

  MemoryCache<List<MemberAttendanceState>> cachedMemberAttendanceList =
      MemoryCache(Duration(minutes: 5));

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
    return Future.value([
      AttendanceData(
          id: 1, attendanceDate: DateTime.now(), type: attendanceType),
      AttendanceData(
          id: 2,
          attendanceDate: DateTime.now().subtract(Duration(days: 7)),
          type: attendanceType),
      AttendanceData(
          id: 3,
          attendanceDate: DateTime.now().subtract(Duration(days: 14)),
          type: attendanceType),
      AttendanceData(
          id: 4,
          attendanceDate: DateTime.now().subtract(Duration(days: 21)),
          type: attendanceType),
    ]);
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
      AttendanceType attendanceType, DateTime searchDate) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await cachedMemberAttendanceList.fetchOrCache(() {
      final isExistSecondAttendance = MockUtil().getRandomBool();

      return Future.value(List.generate(
        MockUtil().getRandomNumber(50, 500),
        (_) {
          final isExistFirst = MockUtil().getRandomNumber(0, 9) < 8;
          DateTime? firstTime;
          AttendanceStatusType? firstResult;

          if (isExistFirst) {
            firstTime = MockUtil().getRandomDateTime(
              DateTime.now(),
              DateTime.now().add(Duration(minutes: 30)),
            );
            final firstTimeout = DateTime.now().add(Duration(minutes: 20));
            final firstFailedTimeout =
                DateTime.now().add(Duration(minutes: 25));

            if (firstTime.isBefore(firstTimeout)) {
              firstResult = AttendanceStatusType.success;
            } else if (firstTime.isBefore(firstFailedTimeout)) {
              firstResult = AttendanceStatusType.late;
            } else {
              firstResult = AttendanceStatusType.failed;
            }
          }

          final isExistSecond = MockUtil().getRandomBool();
          DateTime? secondTime;
          AttendanceStatusType? secondResult;

          if (isExistSecondAttendance && isExistFirst && isExistSecond) {
            secondTime = MockUtil().getRandomDateTime(
              firstTime!,
              firstTime.add(Duration(minutes: 30)),
            );
            final secondTimeout = firstTime.add(Duration(minutes: 20));
            final secondFailedTimeout = firstTime.add(Duration(minutes: 25));

            if (secondTime.isBefore(secondTimeout)) {
              secondResult = AttendanceStatusType.success;
            } else if (secondTime.isBefore(secondFailedTimeout)) {
              secondResult = AttendanceStatusType.late;
            } else {
              secondResult = AttendanceStatusType.failed;
            }
          }
          return MemberAttendanceState(
            name: MockUtil().getRandomKoreanName(),
            grade: MockUtil().getRandomNumber(1, 4),
            partType: MockUtil().getRandomEnum(MemberPartType.values),
            positionType: RegularMember(),
            isExistSecondAttendance: isExistSecondAttendance,
            firstAttendanceCheckTime: firstTime,
            firstAttendanceStatusType: firstResult,
            secondAttendanceCheckTime: secondTime,
            secondAttendanceStatusType: secondResult,
          );
        },
      ));
    });
    return result;
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

  @override
  Future<AttendanceDetailData> getMostRecentAttendance(
      AttendanceType attendanceType) {
    return Future.value(
      AttendanceDetailData(
        id: 1,
        attendanceDate: DateTime.now(),
        type: attendanceType,
      ),
    );
  }

  @override
  Future<AttendanceSummary> getAttendanceSummaryList(
      AttendanceType type, int year, int month) async {
    final maxWeekNumber = MockUtil().getRandomNumber(4, 5);
    final today = DateTime.now();
    final isPreviousMonth =
        today.year > year || today.year == year && today.month > month;
    final isNextMonth =
        today.year < year || today.year == year && today.month < month;

    int generateCount;
    if (isPreviousMonth) {
      generateCount = maxWeekNumber;
    } else if (!isNextMonth) {
      generateCount = MockUtil().getRandomNumber(1, maxWeekNumber);
    } else {
      generateCount = 0;
    }

    today.weekDayIndex;
    return AttendanceSummary(
      maxWeekNumber: maxWeekNumber,
      statusList: List.generate(generateCount, (index) {
            return MockUtil().getRandomEnum(AttendanceStatusType.values,
                except: [
                  AttendanceStatusType.blank,
                  AttendanceStatusType.pending
                ]);
          }) +
          List.generate(maxWeekNumber - generateCount, (index) {
            return AttendanceStatusType.blank;
          }),
    );
  }
}
