import 'package:data/models/remote/home/home_calendar_dto.dart';

abstract class HomeService {
  Future<HomeCalendarDTO> getSchedule();
  Future<List<HomeCalendarDTO>> getAttendanceList();
}
