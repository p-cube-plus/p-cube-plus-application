import 'package:domain/models/home/home_calendar_data.dart';

abstract class HomeService {
  Future<HomeCalendarData> getSchedule();
  Future<List<HomeCalendarData>> getAttendanceList();
}
