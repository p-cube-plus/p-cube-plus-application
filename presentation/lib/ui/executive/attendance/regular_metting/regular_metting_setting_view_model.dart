import 'package:domain/attendance/usecases/fetch_member_attendance_list_use_case.dart';
import 'package:domain/attendance/usecases/fetch_month_attendance_use_case.dart';
import 'package:domain/attendance/usecases/fetch_most_recent_attendance_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
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
  final _fetchMonthAttendanceUseCase = FetchMonthAttendanceUseCase();
  final _fetchMostRecentAttendanceUseCase = FetchMostRecentAttendanceUseCase();

  final AttendanceType attendanceType;

  bool isVisibleTopWidget = true;

  String filterText = "";
  final filterThrottle = Debouncer(Duration(milliseconds: 200));

  List<MemberAttendanceState> _totalList = [];

  RegularMettingSettingViewModel(this.attendanceType);

  void setFilterText(String newText) {
    filterThrottle.run(() {
      filterText = newText;
      notifyListeners();
    });
  }

  Future<AttendanceDetailData> fetchMostRecentAttendance() =>
      _fetchMostRecentAttendanceUseCase.call(attendanceType);

  Future<List<MemberAttendanceState>> fetchUserAttendanceList(
    DateTime selectedDate,
  ) {
    return _fetchUserAttendanceList
        .call(attendanceType, selectedDate)
        .then((result) => _totalList = result);
  }

  List<MemberAttendanceState> get totalList => _totalList
      .where((memberAttendanceData) =>
          memberAttendanceData.name.matchKorean(filterText))
      .toList();

  List<MemberAttendanceState> get successList => _totalList
      .where((memberAttendanceData) =>
          memberAttendanceData.attendanceStatusType ==
              AttendanceStatusType.success &&
          memberAttendanceData.name.matchKorean(filterText))
      .toList();

  List<MemberAttendanceState> get lateList => _totalList
      .where((memberAttendanceData) =>
          memberAttendanceData.attendanceStatusType ==
              AttendanceStatusType.late &&
          memberAttendanceData.name.matchKorean(filterText))
      .toList();

  List<MemberAttendanceState> get failedList => _totalList
      .where((memberAttendanceData) =>
          (memberAttendanceData.attendanceStatusType ==
                  AttendanceStatusType.failed ||
              memberAttendanceData.attendanceStatusType ==
                  AttendanceStatusType.pending) &&
          memberAttendanceData.name.matchKorean(filterText))
      .toList();

  Future<List<AttendanceData>> fetchMonthlyAttendanceList(
    DateTime selectedDate,
  ) {
    return _fetchMonthAttendanceUseCase.call(attendanceType, selectedDate);
  }

  void toggleTopWidgetVisible() {
    isVisibleTopWidget = !isVisibleTopWidget;
    notifyListeners();
  }
}
