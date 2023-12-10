import 'dart:convert';

import 'package:p_cube_plus_application/models/attendance.dart';
import 'package:p_cube_plus_application/models/home_schedule.dart';
import 'package:p_cube_plus_application/models/schedule.dart';

import '../models/rent.dart';
import 'base/pcube_api.dart';

class HomeAttendanceApi extends PCubeApi {
  HomeAttendanceApi() : super(endPoint: "/home/attendance");

  @override
  Future<List<Attendance>> get(
          {Function(dynamic body)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get(
        successReturnFunction: (body) => (jsonDecode(body) as List)
            .map<Attendance>((data) => Attendance.fromJson(data))
            .toList(),
        additionalHeader: additionalHeader,
        queryParams: queryParams,
      );
}

class HomeScheduleApi extends PCubeApi {
  HomeScheduleApi() : super(endPoint: "/home/schedule");

  @override
  Future<HomeSchedule> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => HomeSchedule.fromJson(jsonDecode(body)),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }
}

class HomeProductApi extends PCubeApi {
  HomeProductApi() : super(endPoint: "/home/product");

  @override
  Future<List<Rent>> get(
          {Function(dynamic body)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get(
        successReturnFunction: (body) => (jsonDecode(body) as List)
            .map<Rent>((data) => Rent.fromJson(data))
            .toList(),
        additionalHeader: additionalHeader,
        queryParams: queryParams,
      );
}
