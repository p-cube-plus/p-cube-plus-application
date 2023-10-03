import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/services/home_api.dart';
import '../models/schedule.dart';

// 개인 일정은 어떻게 불러올 것인가?
class ScheduleProvider with ChangeNotifier {
  bool loaded = false;

  late Map<String, List<Schedule>> _dailySchedules; // 일 단위 일정
  late Map<String, List<Schedule>> _monthlySchedules; // 월 단위 일정

  Map<String, List<Schedule>> get dailySchedules => _dailySchedules;
  Map<String, List<Schedule>> get monthlySchedules => _monthlySchedules;

  late HomeApi _homeApi;

  ScheduleProvider() {
    initialize();
  }

  void initialize() {
    _dailySchedules = <String, List<Schedule>>{};
    _monthlySchedules = <String, List<Schedule>>{};
    _homeApi = HomeApi("/schedule");
    loaded = true;
  }

// Month 단위 데이터 가져오기
  Future loadSchedules(DateTime date) async {
    // init 안됐다면 종료
    if (!loaded) return;

    // 이전에 load 됐다면 종료
    String yMDate = DateFormat.yM().format(date);
    if (_monthlySchedules.containsKey(yMDate)) return;

    // year, month로 현재 월 데이터 가져오기
    _monthlySchedules.clear();
    _dailySchedules.clear();
    _monthlySchedules[yMDate] = await _getSchedules(date);

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

  Future<List<Schedule>> _getSchedules(DateTime date) async {
    List<Schedule>? schedules = await _homeApi.getScheduleInfo();
    if (schedules == null) return <Schedule>[];
    return schedules;
  }
}
