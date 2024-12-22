import 'package:data/remote/p_cube_api/user/user_remote_datasource.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:domain/project/value_objects/project_type.dart';
import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_profile.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';
import 'package:get_it/get_it.dart';

class UserRepositoryImpl implements UserRepository {
  final _userRemoteDatasource = GetIt.I.get<UserRemoteDatasource>();

  @override
  Future<UserWarning> getUserCumulativeWarning() async {
    final result = await _userRemoteDatasource.getUserWarning();
    return UserWarning(cumulativeWarningCount: result.totalWarning);
  }

  @override
  Future<UserProfile> getUserProfile() async {
    final result = await _userRemoteDatasource.getUserProfile();
    return UserProfile(
      name: result.name,
      partType: MemberPartType.development,
      memberType: ExecutiveMember("개발자의 최상위 권한"),
    );
  }

  @override
  Future<List<UserProject>> getUserProject() async {
    final result = await _userRemoteDatasource.getUserProject();
    return result.map((value) {
      return UserProject(
        title: value.name,
        projectType: ProjectType.main,
      );
    }).toList();
  }

  @override
  Future<List<UserProjectDetail>> getUserProjectDetail() {
    // TODO: implement getUserProjectDetail
    throw UnimplementedError();
  }

  @override
  Future<UserWarningDetail> getUserWarningDetail() {
    // TODO: implement getUserWarningDetail
    throw UnimplementedError();
  }
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
