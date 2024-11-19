import 'package:domain/attendance/usecases/fetch_attendance_summary_list_use_case.dart';
import 'package:domain/attendance/value_objects/attendance_summary.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeAttendanceSummaryBoxViewModel extends BaseViewModel<void, void> {
  final _fetchAttendanceSummaryListUseCase =
      FetchAttendanceSummaryListUseCase();

  DateTime selectedDateTime = DateTime.now();
  final AttendanceType type;

  HomeAttendanceSummaryBoxViewModel({
    required this.type,
  });

  Future<AttendanceSummary> fetchAttendanceSummaryList() =>
      _fetchAttendanceSummaryListUseCase.call(
        type,
        selectedDateTime,
      );

  void movePreviousMonth() {
    selectedDateTime = selectedDateTime.previousMonthFirstDate;
    notifyListeners();
  }

  void moveNextMonth() {
    selectedDateTime = selectedDateTime.nextMonthFirstDate;
    notifyListeners();
  }
}
