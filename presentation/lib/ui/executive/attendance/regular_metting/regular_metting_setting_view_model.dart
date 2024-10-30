import 'package:domain/attendance/usecases/fetch_member_attendance_list_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_event.dart';

class RegularMettingSettingViewModel
    extends BaseViewModel<RegularMettingSettingEvent, void> {
  final _fetchUserAttendanceList = FetchUserAttendanceListUseCase();

  bool isVisibleTopWidget = true;
  AttendanceType attendanceType = RegularMetting();

  RegularMettingSettingViewModel() {
    fetchData();
  }

  Future<List<MemberAttendanceState>> fetch() => _fetchUserAttendanceList
      .call(attendanceType, DateTime.now())
      .then((result) => totalList = result);

  List<MemberAttendanceState> totalList = [];

  List<MemberAttendanceState> get successList => totalList
      .where((v) => v.attendanceStatusType == AttendanceStatusType.success)
      .toList();

  List<MemberAttendanceState> get lateList => totalList
      .where((v) => v.attendanceStatusType == AttendanceStatusType.late)
      .toList();

  List<MemberAttendanceState> get failedList => totalList
      .where((v) => v.attendanceStatusType == AttendanceStatusType.failed)
      .toList();

  void fetchData() async {
    totalList =
        await _fetchUserAttendanceList.call(attendanceType, DateTime.now());
    notifyListeners();
  }

  void toggleTopWidgetVisible() {
    isVisibleTopWidget = !isVisibleTopWidget;
    notifyListeners();
  }
}
