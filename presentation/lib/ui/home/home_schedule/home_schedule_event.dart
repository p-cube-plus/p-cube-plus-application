sealed class HomeScheduleEvent {}

class HomeScheduleEventOnClickCell implements HomeScheduleEvent {
  final int clickedDay;
  HomeScheduleEventOnClickCell(this.clickedDay);
}

class HomeScheduleEventOnClickPreviousMonth implements HomeScheduleEvent {}

class HomeScheduleEventOnClickNextMonth implements HomeScheduleEvent {}

class HomeScheduleEventScrollPreviousMonth implements HomeScheduleEvent {}

class HomeScheduleEventScrollNextMonth implements HomeScheduleEvent {}
