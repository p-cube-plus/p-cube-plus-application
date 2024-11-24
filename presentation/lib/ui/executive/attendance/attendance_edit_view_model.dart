import 'package:domain/attendance/usecases/fetch_member_attendance_list_use_case.dart';
import 'package:domain/attendance/usecases/fetch_month_attendance_use_case.dart';
import 'package:domain/attendance/usecases/fetch_most_recent_attendance_use_case.dart';
import 'package:domain/attendance/usecases/fetch_next_attendance_schedule_use_case.dart';
import 'package:domain/attendance/usecases/fetch_previous_attendance_schedule_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/utils/debouncer.dart';
import 'package:presentation/utils/match_korean.dart';

class AttendanceEditViewModel extends BaseViewModel<void, void> {
  final _fetchUserAttendanceListUseCase = FetchUserAttendanceListUseCase();
  final _fetchMonthAttendanceUseCase = FetchMonthAttendanceUseCase();
  final _fetchNextAttendanceScheduleUseCase =
      FetchNextAttendanceScheduleUseCase();
  final _fetchPreviousAttendanceScheduleUseCase =
      FetchPreviousAttendanceScheduleUseCase();

  final AttendanceType attendanceType;

  Future<AttendanceDetailData> fetchAttendanceDetailData;

  String filterText = "";
  final filterThrottle = Debouncer(Duration(milliseconds: 200));

  bool isVisibleTopWidget = true;

  AttendanceEditViewModel(this.attendanceType)
      : fetchAttendanceDetailData =
            FetchMostRecentAttendanceUseCase().call(attendanceType);

  void changeSelectedDate(DateTime selectedDate) {
    fetchAttendanceDetailData =
        _fetchUserAttendanceListUseCase.call(attendanceType, selectedDate);
    notifyListeners();
  }

  void moveNextValidDate(DateTime currentDate) {
    fetchAttendanceDetailData =
        _fetchNextAttendanceScheduleUseCase.call(attendanceType, currentDate);
    notifyListeners();
  }

  void movePreviousValidDate(DateTime currentDate) {
    fetchAttendanceDetailData = _fetchPreviousAttendanceScheduleUseCase.call(
        attendanceType, currentDate);
    notifyListeners();
  }

  void setFilterText(String newText) {
    filterThrottle.run(() {
      filterText = newText;
      notifyListeners();
    });
  }

  List<MemberAttendanceState> getTotalList(
          List<MemberAttendanceState> totalList) =>
      totalList
          .where((memberAttendanceData) =>
              memberAttendanceData.name.matchKorean(filterText))
          .toList();

  List<MemberAttendanceState> getSuccessList(
          List<MemberAttendanceState> totalList) =>
      totalList
          .where((memberAttendanceData) =>
              memberAttendanceData.attendanceStatusType ==
                  AttendanceStatusType.success &&
              memberAttendanceData.name.matchKorean(filterText))
          .toList();

  List<MemberAttendanceState> getLateList(
          List<MemberAttendanceState> totalList) =>
      totalList
          .where((memberAttendanceData) =>
              memberAttendanceData.attendanceStatusType ==
                  AttendanceStatusType.late &&
              memberAttendanceData.name.matchKorean(filterText))
          .toList();

  List<MemberAttendanceState> getFailedList(
          List<MemberAttendanceState> totalList) =>
      totalList
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
