import 'dart:convert';

import 'package:p_cube_plus_application/utilities/api_util.dart';

import '../models/project.dart';
import 'base/pcube_api.dart';
import 'package:http/http.dart' as http;

class ProjectListApi {
  Future<Project> get() async {
    var response = await PCubeApi("/project").get();
    return ApiUtil.instance.convertTo<Project>(Project.fromJson, response);
  }
}

class ProjectDetailApi {
  Future<Project> get(int id) async {
    var response = await PCubeApi("/project").get();
    return ApiUtil.instance.convertTo<Project>(Project.fromJson, response);
  }
}

class ProjectModifyApi {
  Future<Project> get(int id) async {
    var response = await PCubeApi("/project").get();
    return ApiUtil.instance.convertTo<Project>(Project.fromJson, response);
  }
}
