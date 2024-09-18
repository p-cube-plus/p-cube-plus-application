import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/remote/p_cube_api/project/response/project_dto.dart';
import 'package:data/utils/json_util.dart';

class ProjectRemoteDatasource {
  Future<List<ProjectResponseDTO>> getUserProjectList() async {
    var response = await PCubeApi().get("/project");
    return JsonUtil().convertToList<ProjectResponseDTO>(
        ProjectResponseDTO.fromJson, response.body);
  }

  Future<List<ProjectResponseDTO>> getAllProjectList() async {
    var response = await PCubeApi().get("/project/all");
    return JsonUtil().convertToList<ProjectResponseDTO>(
        ProjectResponseDTO.fromJson, response.body);
  }
}
