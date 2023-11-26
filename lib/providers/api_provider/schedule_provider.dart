import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';

class ScheduleProvider extends DummyProviderBase<List<Schedule>> {
  bool _isMonthRefresh = true;
  int _cachedYear = -1, _cachedMonth = -1;
  late Map<int, List<Schedule>> _monthSchedule;

  bool _isUpcomingRefresh = true;
  late List<Schedule> _upcomingSchedule;

  bool _isTodayRefresh = true;
  late List<Schedule> _todaySchedule;

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
        startDate: DateTime(2022, 09, 24, 19, 00),
        startTime: "",
        endDate: DateTime.now(),
      ),
    ];
  }

  @override
  Future<List<Schedule>> refresh({Object? parameter}) async {
    _isMonthRefresh = true;
    _isUpcomingRefresh = true;
    _isTodayRefresh = true;
    return await super.refresh(parameter: parameter);
  }

  Future<Map<int, List<Schedule>>> getMonthSchedule(int year, int month) async {
    if (year != _cachedYear || month != _cachedMonth) {
      await refresh();
      _cachedMonth = month;
      _cachedYear = year;
    }

    if (!_isMonthRefresh) return _monthSchedule;
    _isUpcomingRefresh = false;

    int daysInMonth = DateTime(year, month + 1, 0).day;

    Map<int, List<Schedule>> result =
        Map.from({for (int i = 0; i < daysInMonth; ++i) i: <Schedule>[]});

    for (final schedule in data) {
      final startDate = schedule.startDate!;
      final endDate = schedule.endDate ?? startDate;

      for (DateTime day = startDate;
          day.isBefore(endDate);
          day = day.add(const Duration(days: 1))) {
        if (year == day.year && month == day.month) {
          result[day]?.add(schedule);
        }
      }
    }

    _monthSchedule = result;
    return result;
  }

  List<Schedule> getUpcomingSchedule() {
    if (!_isUpcomingRefresh) return _upcomingSchedule;
    _isUpcomingRefresh = false;

    DateTime today = DateTime.now();
    DateTime oneWeekLater = today.add(Duration(days: 7));

    var result = data.where((schedule) {
      return schedule.startDate!.isAfter(today) &&
          schedule.startDate!.isBefore(oneWeekLater);
    }).toList();

    _upcomingSchedule = result;
    return result;
  }

  List<Schedule> getTodaySchedule(DateTime selectedDateTime) {
    return data
        .where((schedule) =>
            schedule.startDate!.compareTo(selectedDateTime) <= 0 &&
            (schedule.endDate ?? schedule.startDate!)
                    .compareTo(selectedDateTime) >=
                0)
        .toList();
  }
}
