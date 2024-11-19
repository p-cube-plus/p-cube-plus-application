import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_summary.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:get_it/get_it.dart';

class FetchAttendanceSummaryListUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<AttendanceSummary> call(
    AttendanceType type,
    DateTime selectedDate,
  ) async {
    final result = await _attendanceRepository.getAttendanceSummaryList(
      type,
      selectedDate.year,
      selectedDate.month,
    );

    // for (int week = 1; week <= result.maxWeekNumber; ++week) {
    //   final index = week - 1;
    //   if (result.length < week || result[index].weekNumber != week) {
    //     result.insert(
    //       index,
    //       AttendanceSummary(
    //         weekNumber: week,
    //         statusType: AttendanceStatusType.blank,
    //       ),
    //     );
    //   }
    // }

    return result;
  }
}
