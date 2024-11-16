import 'package:data/utils/mock_util.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_position_type.dart';
import 'package:domain/project/value_objects/project_type.dart';
import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_profile.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';

class MockUserRepositoryImpl implements UserRepository {
  @override
  Future<UserWarning> getUserCumulativeWarning() async {
    //await Future.microtask(() => throw Exception());
    return Future.value(
      UserWarning(cumulativeWarningCount: 1.5),
    );
  }

  @override
  Future<UserProfile> getUserProfile() {
    return Future.value(UserProfile(
      name: "개발자 테스트",
      partType: MemberPartType.development,
      positionType: Chairman(),
    ));
  }

  @override
  Future<List<UserProject>> getUserProject() async {
    //await Future.microtask(() => throw Exception());
    return Future.value(List.generate(15, (index) {
      return UserProject(
        title: "프로젝트 $index",
        projectType: MockUtil().getRandomEnum(ProjectType.values),
      );
    }));
  }

  @override
  Future<List<UserProjectDetail>> getUserProjectDetail() {
    // TODO: implement getUserProjectDetail
    throw UnimplementedError();
  }

  @override
  Future<List<UserWarningDetail>> getUserWarningDetail() {
    // TODO: implement getUserWarningDetail
    throw UnimplementedError();
  }
}
