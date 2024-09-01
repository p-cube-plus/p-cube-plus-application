import 'package:domain/models/home/home_calendar_data.dart';
import 'package:domain/services/home_service.dart';

import '../../utils/json_util.dart';
import '../http/pcube_api.dart';
import '../models/home/home_calendar_dto.dart';

class HomeServiceImpl implements HomeService {
  @override
  Future<HomeCalendarData> getSchedule() async {
    var response = await PCubeApi("/home/schedule").get();
    return JsonUtil()
        .convertTo<HomeCalendarDTO>(HomeCalendarDTO.fromJson, response.body)
        .toDomain();
  }

  @override
  Future<List<HomeCalendarData>> getAttendanceList() async {
    var response = await PCubeApi("/home/attendance").get();
    return JsonUtil()
        .convertToList<HomeCalendarDTO>(HomeCalendarDTO.fromJson, response.body)
        .map((dto) => dto.toDomain())
        .toList();
  }
}
