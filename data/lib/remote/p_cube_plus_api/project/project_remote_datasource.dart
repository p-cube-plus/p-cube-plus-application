import 'package:data/remote/http/pcube_api.dart';
import 'package:data/remote/p_cube_plus_api/project/response/project_dto.dart';
import 'package:data/utils/json_util.dart';

class ProjectRemoteDatasource {
  Future<List<ProjectResponseDTO>> getUserProjectList() async {
    var response = await PCubeApi("/project").get();
    return JsonUtil().convertToList<ProjectResponseDTO>(
        ProjectResponseDTO.fromJson, response.body);
  }

  Future<List<ProjectResponseDTO>> getAllProjectList() async {
    var response = await PCubeApi("/project/all").get();
    return JsonUtil().convertToList<ProjectResponseDTO>(
        ProjectResponseDTO.fromJson, response.body);
  }
}
