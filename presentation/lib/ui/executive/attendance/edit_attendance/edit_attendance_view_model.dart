import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

class EditAttendanceViewModel extends BaseViewModel<void> {
  DateTime firstAttendanceStartTime;
  DateTime firstAttendanceEndTime;
  DateTime? secondAttendanceStartTime;
  DateTime? secondAttendanceEndTime;

  AttendanceStatusType type;
  DateTime? memberFirstAttendanceTime;
  DateTime? memberSecondAttendanceTime;

  EditAttendanceViewModel({
    required this.firstAttendanceStartTime,
    required this.firstAttendanceEndTime,
    required this.secondAttendanceStartTime,
    required this.secondAttendanceEndTime,
    required this.type,
    required this.memberFirstAttendanceTime,
    required this.memberSecondAttendanceTime,
  }) {
    memberFirstAttendanceTime ??= firstAttendanceStartTime;
    memberSecondAttendanceTime ??= secondAttendanceStartTime;
  }

  bool get isExistSecondAttendance =>
      secondAttendanceStartTime != null && secondAttendanceEndTime != null;

  void changeStatusType(AttendanceStatusType newType) {
    type = newType;
    if (newType == AttendanceStatusType.success) {
      memberFirstAttendanceTime = firstAttendanceStartTime;
      memberSecondAttendanceTime = secondAttendanceStartTime;
    } else if (newType == AttendanceStatusType.late) {
      memberFirstAttendanceTime =
          firstAttendanceEndTime.add(Duration(seconds: 1));
      memberSecondAttendanceTime =
          secondAttendanceEndTime?.add(Duration(seconds: 1));
    } else {
      memberFirstAttendanceTime =
          firstAttendanceEndTime.add(Duration(hours: 1));
      memberSecondAttendanceTime =
          secondAttendanceEndTime?.add(Duration(hours: 1));
    }
    notifyListeners();
  }

  void changeFirstAttendanceTime(DateTime newTime) {
    memberFirstAttendanceTime = newTime;
    notifyListeners();
  }
}
