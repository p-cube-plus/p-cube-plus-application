import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/services/home_api.dart';
import '../models/schedule.dart';

// 개인 일정은 어떻게 불러올 것인가?
class ScheduleProvider with ChangeNotifier {
  Map<String, List<Schedule>> _dailySchedules = <String, List<Schedule>>{};
  Map<String, List<Schedule>> _monthlySchedules = <String, List<Schedule>>{};

  Map<String, List<Schedule>> get dailySchedules => _dailySchedules;
  Map<String, List<Schedule>> get monthlySchedules => _monthlySchedules;

// Month 단위 데이터 가져오기
  Future loadSchedules(DateTime date) async {
    // 이전에 load 됐다면 종료
    String yMDate = DateFormat.yM().format(date);
    if (_monthlySchedules.containsKey(yMDate)) return;

    // year, month로 현재 월 데이터 가져오기
    _monthlySchedules.clear();
    _dailySchedules.clear();
    _monthlySchedules[yMDate] = await _getDummy();

    // day 스케줄 초기화
    for (int i = 0; i < _monthlySchedules[yMDate]!.length; i++) {
      Schedule schedule = _monthlySchedules[yMDate]![i];
      if (schedule.startDate == null) continue;

      for (DateTime d = schedule.startDate!;
          d.difference(schedule.endDate ?? schedule.startDate!).isNegative;
          d = d.add(const Duration(days: 1))) {
        String yMdDate = DateFormat.yMd().format(d);

        _dailySchedules[yMdDate] ??= <Schedule>[];
        _dailySchedules[yMdDate]!.add(schedule);
      }
    }

    notifyListeners();
  }

  List<Schedule> _getDummy() {
    return <Schedule>[
      Schedule(
        type: 0,
        name: "즐거운 추석 보내세요.",
        startDate: DateTime(2023, 09, 28, 00, 00),
        endDate: DateTime(2023, 10, 03, 23, 59),
        hasSpan: false,
      ),
      Schedule(
        type: 0,
        name: "그리고 또 열심히 일합시다.",
        startDate: DateTime(2023, 09, 28, 00, 00),
        endDate: DateTime(2023, 10, 03, 23, 59),
        hasSpan: false,
      ),
      Schedule(
        type: 0,
        name: "가을에 일하기 좋습니다.",
        startDate: DateTime(2023, 09, 28, 00, 00),
        endDate: DateTime(2023, 10, 03, 23, 59),
        hasSpan: false,
      ),
      Schedule(
        type: 1,
        name: "20글자가한계에요. 20글자가한계에요.",
        startDate: DateTime(2022, 09, 24, 19, 00),
        endDate: DateTime(2024, 10, 02, 21, 00),
        hasSpan: false,
      ),
    ];
  }
}
