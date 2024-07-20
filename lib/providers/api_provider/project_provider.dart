import 'package:p_cube_plus_application/remote_f/models/project_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/project_api.dart';

class ProjectProvider extends ApiProviderBase<List<ProjectDTO>> {
  ProjectProvider() : super(getFunction: ProjectListApi().get);

  @override
  Future<List<ProjectDTO>> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }

  List<ProjectDTO> getProjectListByType(String type) {
    return data.where((element) => element.type == type).toList();
  }
}
