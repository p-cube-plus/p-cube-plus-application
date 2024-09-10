import 'package:data/remote/http/pcube_api.dart';
import 'package:data/utils/json_util.dart';

import 'response/home_attendance_response_dto.dart';
import 'response/home_calendar_response_dto.dart';

class HomeRemoteDatasource {
  Future<List<HomeAttendanceResponseDTO>> getHomeAttendance() async {
    var response = await PCubeApi("/home/attendance").get();
    return JsonUtil().convertToList<HomeAttendanceResponseDTO>(
        HomeAttendanceResponseDTO.fromJson, response.body);
  }

  Future<HomeCalendarResponseDTO> getHomeSchedule() async {
    var response = await PCubeApi("/home/schedule").get();
    return JsonUtil().convertTo<HomeCalendarResponseDTO>(
        HomeCalendarResponseDTO.fromJson, response.body);
  }
}
