import 'package:data/models/remote/home/home_calendar_dto.dart';
import 'package:data/source/remote/home_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/pcube_api.dart';

class HomeServiceImpl implements HomeService {
  @override
  Future<HomeCalendarDTO> getSchedule() async {
    var response = await PCubeApi("/home/schedule").get();
    return JsonUtil()
        .convertTo<HomeCalendarDTO>(HomeCalendarDTO.fromJson, response.body);
  }

  @override
  Future<List<HomeCalendarDTO>> getAttendanceList() async {
    var response = await PCubeApi("/home/attendance").get();
    return JsonUtil().convertToList<HomeCalendarDTO>(
        HomeCalendarDTO.fromJson, response.body);
  }
}
