import 'package:p_cube_plus_application/models/project.dart';
import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/project_api.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserProjectProvider extends ApiProviderBase<List<UserProject>> {
  UserProjectProvider() : super(client: new UserProjectApi());

  @override
  Future<List<UserProject>> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}

class UserProjectListProvider extends ApiProviderBase<List<Project>> {
  UserProjectListProvider() : super(client: new ProjectListApi(isAll: false));

  @override
  Future<List<Project>> refresh({
    Map<String, String>? queryParams,
    bool? isAll,
  }) async {
    return await super.refresh(queryParams: queryParams);
  }

  List<Project> getProjectListByType(int type) {
    return data.where((element) => element.type == type).toList();
  }
}
