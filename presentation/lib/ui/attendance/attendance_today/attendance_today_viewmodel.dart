import 'dart:async';

import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/extensions/date_time_extension.dart';

import 'attendance_today_event.dart';
import 'attendance_today_state.dart';

class AttendanceTodayViewmodel
    extends BaseViewModel<AttendanceTodayState, AttendanceTodayEvent> {
  DateTime currentDate;
  AttendanceData firstAttendanceData;
  AttendanceData secondAttendanceData;
  StreamSubscription<DateTime>? _timer;

  String getCheckTimeString(AttendanceData data) {
    if (data.startTime == null) {
      return "아직 ${data.attendanceCheckNumber}차 인증 시간이 정해지지 않았어요.";
    }
    String result = data.startTime!.format("hh시 mm분 ss초");
    if (data.endTime != null) {
      result += " ~ ${data.endTime!.format("hh시 mm분 ss초")}";
    }
    return result;
  }

  AttendanceTodayViewmodel(
    this.currentDate, {
    required this.firstAttendanceData,
    required this.secondAttendanceData,
  }) {
    _setEventListener();
    _startTimer();
  }

  void _setEventListener() {
    userActionEventStream.listen((event) {
      switch (event) {
        case AttendanceTodayEventOnClickAttendance():
          _checkAttendance(event.attendanceCount);
      }
    });
  }

  _checkAttendance(int attendanceCount) {
    if (attendanceCount == 1) {
      // TODO: 출석
    }
    if (attendanceCount == 2) {
      // TODO: 출석
    }
  }

  void _startTimer() {
    _timer = Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now())
        .listen((currentTime) {
      firstAttendanceData.canClick = currentTime.isBetweenDates(
        firstAttendanceData.startTime,
        firstAttendanceData.endTime,
      );
      secondAttendanceData.canClick = currentTime.isBetweenDates(
        secondAttendanceData.startTime,
        secondAttendanceData.endTime,
      );
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class AttendanceData {
  AttendanceType type;
  final int attendanceCheckNumber;
  final DateTime? startTime, endTime;
  DateTime? checkTime;
  bool canClick = false;

  AttendanceData(
    this.type,
    this.startTime,
    this.endTime,
    this.attendanceCheckNumber,
  );

  String getCheckTimeString() {
    if (startTime == null) {
      return "아직 $attendanceCheckNumber차 인증 시간이 정해지지 않았어요.";
    }
    String result = startTime!.format("hh시 mm분 ss초");
    if (endTime != null) {
      result += " ~ ${endTime!.format("hh시 mm분 ss초")}";
    }
    return result;
  }
}

enum AttendanceType {
  off,
  success,
  late,
  fail,
}
