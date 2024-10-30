import 'package:domain/attendance/usecases/fetch_member_attendance_list_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_event.dart';
import 'package:presentation/utils/debouncer.dart';
import 'package:presentation/utils/match_korean.dart';

class RegularMettingSettingViewModel
    extends BaseViewModel<RegularMettingSettingEvent, void> {
  final _fetchUserAttendanceList = FetchUserAttendanceListUseCase();

  bool isVisibleTopWidget = true;
  String filterText = "";
  final filterThrottle = Debouncer(Duration(milliseconds: 200));
  AttendanceType attendanceType = RegularMetting();

  RegularMettingSettingViewModel() {
    fetchData();
  }

  void setFilterText(String newText) {
    filterThrottle.run(() {
      filterText = newText;
      notifyListeners();
    });
  }

  Future<List<MemberAttendanceState>> fetch() => _fetchUserAttendanceList
      .call(attendanceType, DateTime.now())
      .then((result) => _totalList = result);

  List<MemberAttendanceState> _totalList = [];

  List<MemberAttendanceState> get totalList =>
      _totalList.where((v) => v.name.matchKorean(filterText)).toList();

  List<MemberAttendanceState> get successList => _totalList
      .where((v) =>
          v.attendanceStatusType == AttendanceStatusType.success &&
          v.name.matchKorean(filterText))
      .toList();

  List<MemberAttendanceState> get lateList => _totalList
      .where((v) =>
          v.attendanceStatusType == AttendanceStatusType.late &&
          v.name.matchKorean(filterText))
      .toList();

  List<MemberAttendanceState> get failedList => _totalList
      .where((v) =>
          (v.attendanceStatusType == AttendanceStatusType.failed ||
              v.attendanceStatusType == AttendanceStatusType.pending) &&
          v.name.matchKorean(filterText))
      .toList();

  void fetchData() async {
    _totalList =
        await _fetchUserAttendanceList.call(attendanceType, DateTime.now());
    notifyListeners();
  }

  void toggleTopWidgetVisible() {
    isVisibleTopWidget = !isVisibleTopWidget;
    notifyListeners();
  }
}
