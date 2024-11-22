import 'package:domain/attendance/usecases/fetch_member_attendance_list_use_case.dart';
import 'package:domain/attendance/usecases/fetch_month_attendance_use_case.dart';
import 'package:domain/attendance/usecases/fetch_most_recent_attendance_use_case.dart';
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
  final _fetchMostRecentAttendanceUseCase = FetchMostRecentAttendanceUseCase();
  final _fetchUserAttendanceListUseCase = FetchUserAttendanceListUseCase();
  final _fetchMonthAttendanceUseCase = FetchMonthAttendanceUseCase();

  final AttendanceType attendanceType;

  bool isVisibleTopWidget = true;

  String filterText = "";
  final filterThrottle = Debouncer(Duration(milliseconds: 200));

  DateTime? selectedDate;
  List<MemberAttendanceState> _totalList = [];

  RegularMettingSettingViewModel(this.attendanceType);

  Future<AttendanceDetailData> fetchAttendanceDetailData() {
    Future<AttendanceDetailData> result;
    if (selectedDate == null) {
      result = _fetchMostRecentAttendanceUseCase.call(attendanceType);
    } else {
      result = _fetchUserAttendanceListUseCase.call(
        attendanceType,
        selectedDate!,
      );
    }

    return result.then((data) {
      _totalList = data.memberStateList;
      return data;
    });
  }

  void setFilterText(String newText) {
    filterThrottle.run(() {
      filterText = newText;
      notifyListeners();
    });
  }

  Future<AttendanceDetailData> fetchMostRecentAttendance() =>
      _fetchMostRecentAttendanceUseCase.call(attendanceType);

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

  Future<List<int>> fetchValidDateSet(
    DateTime selectedDate,
  ) async {
    final existAttendanceList =
        await _fetchMonthAttendanceUseCase.call(attendanceType, selectedDate);
    return existAttendanceList.map((data) => data.attendanceDate.day).toList();
  }

  void toggleTopWidgetVisible() {
    isVisibleTopWidget = !isVisibleTopWidget;
    notifyListeners();
  }
}
