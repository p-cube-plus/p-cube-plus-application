import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/schedule.dart';

// 개인 일정은 어떻게 불러올 것인가?
class ScheduleProvider with ChangeNotifier {
  bool loaded = false;

  late Map<String, List<Schedule>> _dailySchedules; // 일 단위 일정
  late Map<String, List<Schedule>> _monthlySchedules; // 월 단위 일정

  Map<String, List<Schedule>> get dailySchedules => _dailySchedules;
  Map<String, List<Schedule>> get monthlySchedules => _monthlySchedules;

  ScheduleProvider() {
    initialize();
  }

  void initialize() {
    _dailySchedules = <String, List<Schedule>>{};
    _monthlySchedules = <String, List<Schedule>>{};

    loaded = true;
  }

  Future loadSchedules(DateTime date) async {
    String yMDate = DateFormat.yM().format(date);

    if (!loaded) return;
    if (_monthlySchedules.containsKey(yMDate)) return;

    _monthlySchedules[yMDate] = await _getScheduels(date);

    for (int i = 0; i < _monthlySchedules[yMDate]!.length; i++) {
      Schedule schedule = _monthlySchedules[yMDate]![i];
      if (schedule.startDate == null) continue;

      for (DateTime d = schedule.startDate!;
          d.difference(schedule.endDate ?? schedule.startDate!).inDays <= 0;
          d = d.add(const Duration(days: 1))) {
        String yMdDate = DateFormat.yMd().format(d);

        _dailySchedules[yMdDate] ??= <Schedule>[];
        _dailySchedules[yMdDate]!.add(schedule);
      }
    }

    notifyListeners();
  }

  Future<List<Schedule>> _getScheduels(DateTime date) async {
    if (date.month == 8 && date.year == 2022) // 더미 데이터
      return _getTmpSchedule();
    else // 실제 스케쥴 가져오기
      return <Schedule>[];
  }

  List<Schedule> _getTmpSchedule() {
    return <Schedule>[
      Schedule(
        type: 0,
        name: "판도라큐브 정기회의",
        startDate: DateTime(2022, 08, 03, 15, 00),
        endDate: DateTime(2022, 08, 03, 15, 00),
        hasSpan: false,
      ),
      Schedule(
        type: 0,
        name: "판도라큐브 정기회의",
        startDate: DateTime(2022, 08, 10, 15, 00),
        endDate: DateTime(2022, 08, 10, 15, 00),
        hasSpan: false,
      ),
      Schedule(
        type: 0,
        name: "판도라큐브 정기회의",
        startDate: DateTime(2022, 08, 17, 15, 00),
        endDate: DateTime(2022, 08, 17, 15, 00),
        hasSpan: false,
      ),
      Schedule(
        type: 1,
        name: "아무것도 안하기",
        startDate: DateTime(2022, 08, 17, 18, 00),
        endDate: DateTime(2022, 08, 17, 18, 00),
        hasSpan: false,
      ),
      Schedule(
        type: 1,
        name: "여름 워크샵",
        startDate: DateTime(2022, 08, 23),
        endDate: DateTime(2022, 08, 25),
        hasSpan: true,
      ),
      Schedule(
        type: 0,
        name: "판도라큐브 정기회의",
        startDate: DateTime(2022, 08, 31, 15, 00),
        endDate: DateTime(2022, 08, 31, 15, 00),
        hasSpan: false,
      ),
    ];
  }
}
