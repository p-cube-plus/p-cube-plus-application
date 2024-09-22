import 'package:domain/schedule/usecase/fetch_home_month_schedule_use_case.dart';
import 'package:domain/schedule/usecase/fetch_home_today_schedule_use_case.dart';
import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:domain/schedule/value_objects/schedule_detail.dart';
import 'package:presentation/common/base_viewmodel.dart';

import 'home_schedule_event.dart';

class HomeScheduleViewmodel extends BaseViewModel<void, HomeScheduleEvent> {
  final _fetchHomeMonthScheduleUseCase = FetchHomeMonthScheduleUseCase();
  final _fetchHomeTodayScheduleUseCase = FetchHomeTodayScheduleUseCase();

  DateTime selectedDate = DateTime.now();

  HomeScheduleViewmodel() {
    _setEventListener();
  }

  void _setEventListener() {
    userActionEventStream.listen((event) {
      switch (event) {
        case HomeScheduleEventOnClickCell():
          changeCurrentDate(event.clickedDay);
        case HomeScheduleEventOnClickPreviousMonth():
          jumpToOneMonthAgo();
        case HomeScheduleEventOnClickNextMonth():
          jumpToOneMonthLater();
        case HomeScheduleEventScrollPreviousMonth():
          jumpToOneMonthAgo();
        case HomeScheduleEventScrollNextMonth():
          jumpToOneMonthLater();
      }
    });
  }

  Future<Map<int, ScheduleData>> fetchHomeMonthSchedule() {
    return _fetchHomeMonthScheduleUseCase.call(
        selectedDate.year, selectedDate.month);
  }

  Future<List<ScheduleDetail>> fetchHomeTodaySchedule() {
    return _fetchHomeTodayScheduleUseCase.call(selectedDate);
  }

  void changeCurrentDate(int selectedDay) {
    selectedDate = selectedDate.copyWith(day: selectedDay);
  }

  void jumpToOneMonthLater() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
  }

  void jumpToOneMonthAgo() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
  }
}
