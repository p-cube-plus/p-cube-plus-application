import '../models/home_calendar_data.dart';

abstract interface class ScheduleRepository {
  Future<HomeCalendarData> getSchedule();
}
