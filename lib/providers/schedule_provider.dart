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

  Future initData() async {
    if (_monthlySchedules.isNotEmpty) _monthlySchedules.clear();

    List<Schedule>? scheduleList = await HomeSchueduleApi().getScheduleInfo();
    scheduleList?.forEach((element) {
      // 일정이 여러 month에 걸쳐 있으면 각 month에 모두 일정을 추가
      // 여러 달에 걸쳐 있지 않으면 시작 month에만 추가
      for (DateTime date = element.startDate;
          date.isBefore(element.endDate ?? element.startDate) ||
              date.isAtSameMomentAs(element.endDate ?? element.startDate);
          date = DateTime(date.year, date.month + 1, 1)) {
        String yMDate = DateFormat.yM().format(date);

        _monthlySchedules[yMDate] ??= <Schedule>[];
        _monthlySchedules[yMDate]?.add(element);
      }
    });
  }

// Month 단위 데이터 가져오기
  Future loadSchedules(DateTime date) async {
    // year, month로 현재 월 데이터 가져오기
    String yMDate = DateFormat.yM().format(date);

    // day 스케줄 초기화
    _dailySchedules.clear();

    // year, month에 해당하는 스케줄이 없는 경우
    if (!_monthlySchedules.containsKey(yMDate)) return;

    // daily 반영
    for (int i = 0; i < _monthlySchedules[yMDate]!.length; i++) {
      Schedule schedule = _monthlySchedules[yMDate]![i];

      // 로직 점검 필요.
      for (DateTime d = schedule.startDate;
          d.difference(schedule.endDate ?? schedule.startDate) <= Duration.zero;
          d = d.add(const Duration(days: 1))) {
        String yMdDate = DateFormat.yMd().format(d);

        _dailySchedules[yMdDate] ??= <Schedule>[];
        _dailySchedules[yMdDate]!.add(schedule);
      }
    }

    notifyListeners();
  }
}
