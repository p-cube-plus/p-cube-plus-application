import 'package:data/models/remote/project/project_dto.dart';
import 'package:data/source/remote/project_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/pcube_api.dart';

class ProjectServiceImpl implements ProjectService {
  @override
  Future<List<ProjectDTO>> getProject() async {
    var response = await PCubeApi("/project").get();
    return JsonUtil()
        .convertToList<ProjectDTO>(ProjectDTO.fromJson, response.body);
  }
}
