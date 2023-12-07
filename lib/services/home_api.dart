import 'dart:convert';

import 'package:p_cube_plus_application/models/attendance.dart';
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

// TODO: API 개발 기다리는 중.
// queryParams를 통해 스케줄의 일부분만 가져와야 함.
// 년단위나 월단위 안 됨. 다가오는 일정이 일주일 이후까지 보여줘야 돼서
// 2달치 가져오면 될 듯?
class HomeScheduleApi extends PCubeApi {
  HomeScheduleApi() : super(endPoint: "/home/schedule");

  @override
  Future<List<Schedule>> get(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (body) => (jsonDecode(body) as List)
          .map<Schedule>((data) => Schedule.fromJson(data))
          .toList(),
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
