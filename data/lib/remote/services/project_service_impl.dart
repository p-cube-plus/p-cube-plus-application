import 'package:domain/models/project/project_data.dart';
import 'package:domain/services/project_service.dart';

import '../../utils/json_util.dart';
import '../http/pcube_api.dart';
import '../models/project/project_dto.dart';

class ProjectServiceImpl implements ProjectService {
  @override
  Future<List<ProjectData>> getProject() async {
    var response = await PCubeApi("/project").get();
    return JsonUtil()
        .convertToList<ProjectDTO>(ProjectDTO.fromJson, response.body)
        .map((dto) => dto.toDomain())
        .toList();
  }
}
