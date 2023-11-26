import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';

class ScheduleProvider extends DummyProviderBase<List<Schedule>> {
  int _cachedYear = -1, _cachedMonth = -1;
  Map<int, List<Schedule>>? _cachedMonthSchedule;

  @override
  List<Schedule> getDummy({Object? parameter}) {
    return <Schedule>[
      Schedule(
        id: 1,
        type: 0,
        title: "즐거운 추석 보내세요.",
        startDate: DateTime(2023, 09, 28, 00, 00),
        startTime: "",
        endDate: DateTime(2023, 10, 03, 23, 59),
      ),
      Schedule(
        id: 2,
        type: 0,
        title: "그리고 또 열심히 일합시다.",
        startDate: DateTime(2023, 09, 28, 00, 00),
        startTime: "",
        endDate: DateTime(2023, 10, 03, 23, 59),
      ),
      Schedule(
        id: 3,
        type: 0,
        title: "가을에 일하기 좋습니다.",
        startDate: DateTime(2023, 09, 28, 00, 00),
        startTime: "",
        endDate: DateTime(2023, 10, 03, 23, 59),
      ),
      Schedule(
        id: 4,
        type: 1,
        title: "20글자가한계에요. 20글자가한계에요.",
        startDate: DateTime(2023, 7, 25, 19, 00),
        startTime: "",
        endDate: DateTime.now(),
      ),
      Schedule(
        id: 5,
        type: 1,
        title: "앞으로의 일",
        startDate: DateTime.now().add(Duration(days: 1)),
        startTime: "",
        endDate: DateTime.now().add(Duration(days: 3)),
      ),
    ];
  }

  @override
  Future<List<Schedule>> refresh({Object? parameter}) async {
    return await super.refresh(parameter: parameter);
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

    for (final schedule in data) {
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
    DateTime today = DateTime.now();
    DateTime oneWeekLater = new DateTime(today.year, today.month, today.day + 1)
        .add(Duration(days: 7));

    return data
        .where((schedule) =>
            schedule.startDate.isAfter(today) &&
            schedule.startDate.isBefore(oneWeekLater))
        .toList();
  }

  List<Schedule> getSelectScheduleList(DateTime selectedDateTime) {
    return data
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
