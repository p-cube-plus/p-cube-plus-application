import 'package:p_cube_plus_application/utilities/json_util.dart';
import '../models/project.dart';
import 'base/pcube_api.dart';

class ProjectListApi {
  Future<Project> get() async {
    var response = await PCubeApi("/project").get();
    return JsonUtil.instance
        .convertTo<Project>(Project.fromJson, response.body);
  }
}

class ProjectDetailApi {
  Future<Project> get(int id) async {
    var response = await PCubeApi("/project").get();
    return JsonUtil.instance
        .convertTo<Project>(Project.fromJson, response.body);
  }
}

class ProjectModifyApi {
  Future<Project> get(int id) async {
    var response = await PCubeApi("/project").get();
    return JsonUtil.instance
        .convertTo<Project>(Project.fromJson, response.body);
  }
}
