import 'dart:convert';

import 'package:p_cube_plus_application/models/attendance.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/rent.dart';
import 'pcube_api.dart';

class HomeApi extends PCubeApi {
  HomeApi(String endPoint) : super(endPoint: "/home$endPoint");

  Future<List<Attendance>?> getAttendanceInfo() async {
    final token = TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
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

  Future<List<Schedule>?> getScheduleInfo() async {
    final token = TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        List<dynamic> json = jsonDecode(response.body);
        List<Schedule> scheduleList =
            json.map<Schedule>((e) => Schedule.fromJson(e)).toList();

        return scheduleList;
      default:
        return null;
    }
  }

  Future<List<Rent>?> getRentList() async {
    final token = TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        List<dynamic> json = jsonDecode(response.body);
        List<Rent> rentList = json.map<Rent>((e) => Rent.fromJson(e)).toList();

        return rentList;
      default:
        return null;
    }
  }
}
