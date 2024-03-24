import 'package:p_cube_plus_application/models/home_schedule.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/home_api.dart';

class ScheduleProvider extends ApiProviderBase<HomeSchedule> {
  ScheduleProvider() : super(getFunction: HomeScheduleApi().get);
  int _cachedYear = -1, _cachedMonth = -1;
  Map<int, List<Schedule>>? _cachedMonthSchedule;

  @override
  Future<HomeSchedule> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }

  Future<Map<int, List<Schedule>>> getMonthSchedule(
      DateTime currentDate) async {
    int year = currentDate.year;
    int month = currentDate.month;

    if (year == _cachedYear && month == _cachedMonth) {
      return _cachedMonthSchedule!;
    }

    _cachedMonth = month;
    _cachedYear = year;

    Map<int, List<Schedule>> result = {};

    for (final schedule in data.allList) {
      final startDate = schedule.startDate;
      final endDate = schedule.endDate ?? startDate;

      for (DateTime day = startDate;
          day.isBefore(endDate);
          day = day.add(const Duration(days: 1))) {
        if (day.year == year && day.month == month) {
          result[day.day] ??= <Schedule>[];
          result[day.day]!.add(schedule);
        }
      }
    }

    _cachedMonthSchedule = result;

    return result;
  }

  List<Schedule> getUpcomingSchedule() {
    return data.upcomingList;
  }

  List<Schedule> getSelectScheduleList(DateTime selectedDateTime) {
    return data.allList
        .where((schedule) => isDateTimeInRange(selectedDateTime,
            schedule.startDate, schedule.endDate ?? schedule.startDate))
        .toList();
  }

  bool isDateTimeInRange(
      DateTime selectedDateTime, DateTime startDate, DateTime endDate) {
    startDate = DateTime(startDate.year, startDate.month, startDate.day);
    endDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);

    selectedDateTime = DateTime(
        selectedDateTime.year, selectedDateTime.month, selectedDateTime.day);

    return !selectedDateTime.isBefore(startDate) &&
        !selectedDateTime.isAfter(endDate);
  }
}
