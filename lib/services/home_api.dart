import 'dart:convert';

import 'package:p_cube_plus_application/models/attendance.dart';

import '../models/rent.dart';
import 'pcube_api.dart';

class HomeApi extends PCubeApi {
  HomeApi() : super(endPoint: "/home");

  Future<List<Attendance>?> getAttendanceInfo() async {
    Map<String, String>? headers = {"Content-Type": "application/json"};
    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        List<dynamic> json = jsonDecode(response.body);
        List<Attendance> attendanceList =
            json.map<Attendance>((e) => Attendance.fromJson(e)).toList();
        return attendanceList;
      default:
        return null;
    }
  }

  /*Future<> getScheduleInfo() async {

  }*/

  Future<List<Rent>?> getRentList() async {
    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer"
    };

    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        List<dynamic> json = jsonDecode(response.body);
        //print(response.body);

        List<Rent> rentList = json.map<Rent>((e) => Rent.fromJson(e)).toList();

        return rentList;
      default:
        return null;
    }
  }
}
