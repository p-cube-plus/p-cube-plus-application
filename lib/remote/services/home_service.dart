import 'package:p_cube_plus_application/remote/models/rent_dto.dart';
import 'package:p_cube_plus_application/remote/models/home_schedule_dto.dart';
import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class HomeService {
  Future<HomeScheduleDTO> getSchedule() async {
    var response = await PCubeApi("/home/schedule").get();
    return JsonUtil()
        .convertTo<HomeScheduleDTO>(HomeScheduleDTO.fromJson, response.body);
  }

  Future<List<ScheduleDTO>> getAttendanceList() async {
    var response = await PCubeApi("/home/attendance").get();
    return JsonUtil()
        .convertToList<ScheduleDTO>(ScheduleDTO.fromJson, response.body);
  }

  Future<RentDTO> getRentProduct() async {
    var response = await PCubeApi("/home/product").get();
    return JsonUtil().convertTo<RentDTO>(RentDTO.fromJson, response.body);
  }
}
