import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/models/project_dto.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class ProjectService {
  Future<List<ProjectDTO>> getProject() async {
    var response = await PCubeApi("/project").get();
    return JsonUtil()
        .convertToList<ProjectDTO>(ProjectDTO.fromJson, response.body);
  }
}
