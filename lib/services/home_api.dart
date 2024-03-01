import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/models/attendance.dart';
import 'package:p_cube_plus_application/models/home_schedule.dart';

import '../models/rent.dart';
import 'base/pcube_api.dart';

class HomeScheduleApi extends PCubeApi {
  HomeScheduleApi() : super(endPoint: "/home/schedule");

  @override
  Future<HomeSchedule> get(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (response) =>
          HomeSchedule.fromJson(jsonDecode(response.body)),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }
}

class HomeAttendanceApi extends PCubeApi {
  HomeAttendanceApi() : super(endPoint: "/home/attendance");

  @override
  Future<List<Attendance>> get(
          {Function(http.Response response)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get(
        successReturnFunction: (response) => (jsonDecode(response.body) as List)
            .map<Attendance>((data) => Attendance.fromJson(data))
            .toList(),
        additionalHeader: additionalHeader,
        queryParams: queryParams,
      );
}

class HomeProductApi extends PCubeApi {
  HomeProductApi() : super(endPoint: "/home/product");

  @override
  Future<List<Rent>> get(
          {Function(http.Response response)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get(
        successReturnFunction: (response) => (jsonDecode(response.body) as List)
            .map<Rent>((data) => Rent.fromJson(data))
            .toList(),
        additionalHeader: additionalHeader,
        queryParams: queryParams,
      );
}
