import 'dart:async';

import 'package:domain/attendance/usecases/attend_use_case.dart';
import 'package:domain/attendance/usecases/fetch_attendance_state_use_case.dart';
import 'package:domain/attendance/usecases/fetch_recent_attendance_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/extensions/date_time_extension.dart';

import 'attendance_today_event.dart';
import 'attendance_today_state.dart';

class AttendanceTodayViewmodel
    extends BaseViewModel<AttendanceTodayState, AttendanceTodayEvent> {
  final _fetchAttendanceStateUseCase = FetchAttendanceStateUseCase();
  final _fetchRecentAttendanceUseCase = FetchRecentAttendanceUseCase();
  final _attendUseCase = AttendUseCase();

  AttendanceData selectedAttendance;
  StreamSubscription<DateTime>? _timer;
  bool isFirstAttendanceTime = false;
  bool isSecondAttendanceTime = false;
  bool shouldRefresh = false;

  AttendanceTodayViewmodel(
    this.selectedAttendance,
  ) {
    _setEventListener();
  }

  Future<List<TodayAttendance>> fetchStateData() {
    return _fetchAttendanceStateUseCase.call(selectedAttendance);
  }

  Future<List<RecentAttendance>> fetchRecentData() {
    return _fetchRecentAttendanceUseCase.call(selectedAttendance.type);
  }

  void _setEventListener() {
    userActionEventStream.listen((event) {
      switch (event) {
        case AttendanceTodayEventOnClickAttendance():
          _checkAttendance(event.data);
        case CheckTimeToCanAttendance():
          _startTimer(event.data);
      }
    });
  }

  void _checkAttendance(TodayAttendance data) {
    _attendUseCase.call(data).then((data) {
      shouldRefresh = true;
      notifyListeners();
    }).catchError((error) {
      changeState(AttendanceTodayState.showFailedDialog);
    });
  }

  void _startTimer(List<TodayAttendance> attendanceList) {
    _timer?.cancel();
    _timer = Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now())
        .listen((currentTime) {
      final isFirstAttendanceTimeOldValue = isFirstAttendanceTime;
      isFirstAttendanceTime = currentTime.isBetweenDates(
        attendanceList[0].startTime,
        attendanceList[0].endTime,
      );

      final isSecondAttendanceTimeOldValue = isSecondAttendanceTime;
      isSecondAttendanceTime = currentTime.isBetweenDates(
        attendanceList[1].startTime,
        attendanceList[1].endTime,
      );

      if (isFirstAttendanceTimeOldValue != isFirstAttendanceTime ||
          isSecondAttendanceTimeOldValue != isSecondAttendanceTime) {
        notifyListeners();
      }

      if (isFirstAttendanceTime && isSecondAttendanceTime) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
