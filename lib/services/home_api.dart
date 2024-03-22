import 'package:p_cube_plus_application/models/home_schedule.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/utilities/api_util.dart';

import '../models/rent.dart';
import 'base/pcube_api.dart';

class HomeScheduleApi {
  Future<HomeSchedule> get() async {
    var response = await PCubeApi("/home/schedule").get();
    return ApiUtil.instance.convertTo<HomeSchedule>(HomeSchedule.fromJson, response);
  }
}

class HomeAttendanceApi {
  Future<List<Schedule>> get() async {
    var response = await PCubeApi("/home/attendance").get();
    return ApiUtil.instance.convertToList<Schedule>(Schedule.fromJson, response);
  }
}

class HomeProductApi {
  Future<Rent> get() async {
    var response = await PCubeApi("/home/product").get();
    return ApiUtil.instance.convertTo<Rent>(Rent.fromJson, response);
  }
}
