import 'dart:async';

import 'package:domain/attendance/usecases/attend_use_case.dart';
import 'package:domain/attendance/usecases/fetch_attendance_state_use_case.dart';
import 'package:domain/attendance/usecases/fetch_recent_attendance_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';

import 'attendance_today_event.dart';
import 'attendance_today_state.dart';

class AttendanceTodayViewmodel
    extends BaseViewModel<AttendanceTodayState, AttendanceTodayEvent> {
  final _fetchAttendanceStateUseCase = FetchAttendanceStateUseCase();
  final _fetchRecentAttendanceUseCase = FetchRecentAttendanceUseCase();
  final _attendUseCase = AttendUseCase();

  AttendanceData selectedAttendance;
  StreamSubscription<DateTime>? _timer;
  bool isPossibleFirstAttendance = false;
  bool isPossibleSecondAttendance = false;
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
    uiEventStream.listen((event) {
      switch (event) {
        case AttendanceTodayEventOnClickAttendance():
          _checkAttendance(event.data);
        case CheckTimeToCanAttendance():
          _startCheckCanAttendanceTimer(event.data);
      }
    });
  }

  void _checkAttendance(TodayAttendance data) {
    _attendUseCase.call(data).then((data) {
      shouldRefresh = true;
      notifyListeners();
    }).catchError((error) {
      triggerEvent(AttendanceTodayState.showFailedDialog);
    });
  }

  void _startCheckCanAttendanceTimer(List<TodayAttendance> attendanceList) {
    _timer?.cancel();
    _timer = Stream.periodic(
            const Duration(microseconds: 500), (_) => DateTime.now())
        .listen((currentTime) {
      final firstOldValue = isPossibleFirstAttendance;
      final secondOldValue = isPossibleSecondAttendance;

      isPossibleFirstAttendance = _canAttend(attendanceList[0]);
      isPossibleSecondAttendance = _canAttend(attendanceList[1]);

      if (firstOldValue != isPossibleFirstAttendance ||
          secondOldValue != isPossibleSecondAttendance) {
        notifyListeners();
      }

      if (firstOldValue && secondOldValue) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  bool _canAttend(TodayAttendance data) {
    final isAvailableTime =
        DateTime.now().isBetweenDates(data.startTime, data.endTime);
    return isAvailableTime; // isBeaconDetected
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
