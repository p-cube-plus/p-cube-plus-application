import 'package:p_cube_plus_application/models/attendance.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/rent.dart';

class HomeAttendanceApi extends PCubeApi {
  HomeAttendanceApi() : super(endPoint: "/home/attendance");

  @override
  Future<List<Attendance>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) =>
          jsonDecodeData.map((e) => Attendance.fromJson(e)).toList(),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<List<Attendance>?> getAttendanceInfo() async {
    final token = TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var response = await get(headers: headers);

    return response;
  }
}

class HomeSchueduleApi extends PCubeApi {
  HomeSchueduleApi() : super(endPoint: "/home/schedule");

  @override
  Future<List<Schedule>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) => (jsonDecodeData as List)
          .map((data) => Schedule.fromJson(data))
          .toList(),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<List<Schedule>?> getScheduleInfo() async {
    String? token = await TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}

class HomeRentApi extends PCubeApi {
  HomeRentApi() : super(endPoint: "/home/product");

  @override
  Future<List<Rent>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) =>
          jsonDecodeData.map((e) => Rent.fromJson(e)).toList(),
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<List<Rent>?> getRentList() async {
    final token = TokenManager().getAccessToken();

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response = await get(headers: headers);

    return response;
  }
}
