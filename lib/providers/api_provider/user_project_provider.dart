import 'package:p_cube_plus_application/remote_f/models/project_dto.dart';
import 'package:p_cube_plus_application/remote_f/models/user_project_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/project_api.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserProjectProvider extends ApiProviderBase<List<UserProjectDTO>> {
  UserProjectProvider() : super(getFunction: UserProjectApi().get);

  @override
  Future<List<UserProjectDTO>> refresh(
      {Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}

class UserProjectListProvider extends ApiProviderBase<List<ProjectDTO>> {
  UserProjectListProvider() : super(getFunction: ProjectListApi().get);

  @override
  Future<List<ProjectDTO>> refresh({
    Map<String, String>? queryParams,
    bool? isAll,
  }) async {
    return await super.refresh(queryParams: queryParams);
  }

  List<ProjectDTO> getProjectListByType(int type) {
    return data.where((element) => element.type == type).toList();
  }
}
