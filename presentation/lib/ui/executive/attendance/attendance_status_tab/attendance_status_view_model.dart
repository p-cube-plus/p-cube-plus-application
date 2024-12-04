import 'package:domain/attendance/usecases/fetch_member_attendance_list_use_case.dart';
import 'package:domain/attendance/usecases/fetch_month_attendance_use_case.dart';
import 'package:domain/attendance/usecases/fetch_most_recent_attendance_use_case.dart';
import 'package:domain/attendance/usecases/fetch_next_attendance_schedule_use_case.dart';
import 'package:domain/attendance/usecases/fetch_previous_attendance_schedule_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:domain/member/usecases/fetch_member_filter_use_case.dart';
import 'package:domain/member/value_objects/member_filter.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/utils/debouncer.dart';
import 'package:presentation/utils/match_korean.dart';

class AttendanceStatusViewModel extends BaseViewModel<void, void> {
  final _fetchUserAttendanceListUseCase = FetchUserAttendanceListUseCase();
  final _fetchMonthAttendanceUseCase = FetchMonthAttendanceUseCase();
  final _fetchNextAttendanceScheduleUseCase =
      FetchNextAttendanceScheduleUseCase();
  final _fetchPreviousAttendanceScheduleUseCase =
      FetchPreviousAttendanceScheduleUseCase();
  final _fetchMemberFilterUseCase = FetchMemberFilterUseCase();

  final AttendanceType attendanceType;
  late MemberFilter memberFilter;
  late Future<AttendanceDetailData> fetchAttendanceDetailData;

  String filterText = "";
  final filterThrottle = Debouncer(Duration(milliseconds: 200));

  bool isVisibleTopWidget = true;

  AttendanceStatusViewModel(this.attendanceType) {
    memberFilter = _fetchMemberFilterUseCase.call();
    fetchAttendanceDetailData =
        FetchMostRecentAttendanceUseCase().call(attendanceType);
  }

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

  void setMemberFilter(MemberFilter filter) {
    memberFilter = filter;
    notifyListeners();
  }

  List<MemberAttendanceState> getTotalList(
          List<MemberAttendanceState> totalList) =>
      totalList.filter(memberFilter, filterText);

  List<MemberAttendanceState> getSuccessList(
          List<MemberAttendanceState> totalList) =>
      getTotalList(totalList)
          .where((data) =>
              data.attendanceStatusType == AttendanceStatusType.success)
          .toList();

  List<MemberAttendanceState> getLateList(
          List<MemberAttendanceState> totalList) =>
      getTotalList(totalList)
          .where(
              (data) => data.attendanceStatusType == AttendanceStatusType.late)
          .toList();

  List<MemberAttendanceState> getFailedList(
          List<MemberAttendanceState> totalList) =>
      getTotalList(totalList)
          .where((data) =>
              data.attendanceStatusType == AttendanceStatusType.failed ||
              data.attendanceStatusType == AttendanceStatusType.blank ||
              data.attendanceStatusType == AttendanceStatusType.pending)
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

extension MemberSortExtension on List<MemberAttendanceState> {
  List<MemberAttendanceState> filter(MemberFilter filter, String filterText) {
    final filtedResult = where((data) =>
        data.name.matchKorean(filterText) &&
        (filter.isShowOnlyActiveMember
            ? data.memberType.isActiveMember
            : true)).toList();

    if (filter.memberNameSortType == SortType.ascend) {
      filtedResult.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filtedResult.sort((a, b) => b.name.compareTo(a.name));
    }

    return filtedResult;
  }
}
