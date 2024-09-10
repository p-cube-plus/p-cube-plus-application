import '../models/home_calendar_data.dart';

abstract class ScheduleRepository {
  Future<HomeCalendarData> getSchedule();
}