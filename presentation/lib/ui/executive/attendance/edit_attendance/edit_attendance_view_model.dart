import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

class EditAttendanceViewModel extends BaseViewModel<void, void> {
  AttendanceStatusType type;
  DateTime firstAttendanceTime;
  DateTime? secondAttendanceTime;

  EditAttendanceViewModel({
    required this.type,
    required this.firstAttendanceTime,
    this.secondAttendanceTime,
  });

  bool get isExistSecondAttendance => secondAttendanceTime != null;

  void changeStatusType(AttendanceStatusType newType) {
    type = newType;
    notifyListeners();
  }
}
