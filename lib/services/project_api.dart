import 'dart:convert';

import '../models/project.dart';
import 'base/pcube_api.dart';

class ProjectListApi extends PCubeApi {
  ProjectListApi({bool? isAll})
      : super(
            endPoint:
                "/project${(isAll != null) ? (isAll ? "/all" : "") : ""}");

  @override
  Future<List<Project>> get(
          {Function(dynamic body)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get(
        successReturnFunction: (body) => (jsonDecode(body) as List)
            .map<Project>((data) => Project.fromJson(data))
            .toList(),
        additionalHeader: additionalHeader,
        queryParams: queryParams,
      );
}

class ProjectDetailApi extends PCubeApi {
  ProjectDetailApi(int id) : super(endPoint: "/project/${id.toString()}");

  @override
  Future<List<Project>> get(
          {Function(dynamic body)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Map<String, String>? queryParams}) async =>
      await super.get();
}

class ProjectModifyApi extends PCubeApi {
  ProjectModifyApi(int id)
      : super(endPoint: "/project/${id.toString()}/modify");

  @override
  Future<List<Project>> post(
          {Function(dynamic body)? successReturnFunction,
          Map<String, String>? additionalHeader,
          Object? body,
          Encoding? encoding}) async =>
      await super.post();
}
