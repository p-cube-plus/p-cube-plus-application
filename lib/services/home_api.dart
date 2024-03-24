import 'package:p_cube_plus_application/models/home_schedule.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/utilities/json_util.dart';

import '../models/rent.dart';
import 'base/pcube_api.dart';

class HomeScheduleApi {
  Future<HomeSchedule> get() async {
    var response = await PCubeApi("/home/schedule").get();
    return JsonUtil.instance
        .convertTo<HomeSchedule>(HomeSchedule.fromJson, response.body);
  }
}

class HomeAttendanceApi {
  Future<List<Schedule>> get() async {
    var response = await PCubeApi("/home/attendance").get();
    return JsonUtil.instance
        .convertToList<Schedule>(Schedule.fromJson, response.body);
  }
}

class HomeProductApi {
  Future<Rent> get() async {
    var response = await PCubeApi("/home/product").get();
    return JsonUtil.instance.convertTo<Rent>(Rent.fromJson, response.body);
  }
}
