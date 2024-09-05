import 'dart:ui';

import 'package:presentation/common/base_viewmodel.dart';

import 'home_schedule_event.dart';
import 'upcomming_schedule/upcomming_schedule_item/home_upcomming_schedule_data.dart';

class HomeScheduleViewmodel extends BaseViewModel<void, HomeScheduleEvent> {
  DateTime currentDate = DateTime.now();
  List<HomeUpcommingScheduleData> upcommingScheduleData = [];

  Map<int, List<HomeScheduleData>> monthSchedule = {};
  Map<int, Color> scheduleColorList = {};

  HomeScheduleViewmodel() {
    _setEventListener();
  }

  void _setEventListener() {
    eventStream.listen((event) {
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

  Future<void> fetchData() async {}

  Future<void> refreshData() async {}

  void changeCurrentDate(int selectedDay) {
    currentDate = currentDate.copyWith(day: selectedDay);
  }

  // 다가오는 일정이 날짜를 watch 중이기 때문에
  // 스케줄 데이터를 먼저 가져와야 한다.
  void jumpToOneMonthLater() {
    // TODO: 스케줄 데이터 새로 가져오기
    currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
  }

  // 다가오는 일정이 날짜를 watch 중이기 때문에
  // 스케줄 데이터를 먼저 가져와야 한다.
  void jumpToOneMonthAgo() {
    // TODO: 스케줄 데이터 새로 가져오기
    currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
  }
}

class HomeScheduleData {
  final Color scheduleColor;
  final DateTime startTime;
  final String title;
  HomeScheduleData(
    this.scheduleColor,
    this.startTime,
    this.title,
  );
}
