import 'package:p_cube_plus_application/models/project.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/project_api.dart';

class ProjectProvider extends ApiProviderBase<List<Project>> {
  ProjectProvider() : super(getFunction: ProjectListApi().get);

  @override
  Future<List<Project>> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }

  List<Project> getProjectListByType(String type) {
    return data.where((element) => element.type == type).toList();
  }
}
