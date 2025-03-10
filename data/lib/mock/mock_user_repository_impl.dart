import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/utils/mock_util.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:domain/member/value_objects/member_warning_type.dart';
import 'package:domain/project/value_objects/project_type.dart';
import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_profile.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:domain/user/value_objects/user_warning_content.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';
import 'package:get_it/get_it.dart';

class MockUserRepositoryImpl implements UserRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();

  @override
  Future<UserWarning> getUserCumulativeWarning() async {
    await MockUtil().applyMockSetting();

    return Future.value(
      UserWarning(cumulativeWarningCount: 1.5),
    );
  }

  @override
  Future<UserProfile> getUserProfile() async {
    await MockUtil().applyMockSetting();

    return Future.value(UserProfile(
      name: "개발자 테스트",
      partType: MemberPartType.development,
      memberType: ExecutiveMember("개발자의 최상위 권한"),
    ));
  }

  @override
  Future<List<UserProject>> getUserProject() async {
    await MockUtil().applyMockSetting();

    return Future.value(List.generate(15, (index) {
      return UserProject(
        title: "프로젝트 $index",
        projectType: MockUtil().getRandom(ProjectType.values),
      );
    }));
  }

  @override
  Future<List<UserProjectDetail>> getUserProjectDetail() async {
    await MockUtil().applyMockSetting();

    return Future.value(List.generate(10, (index) {
      return UserProjectDetail(
        projectId: index,
        title: "프로젝트 $index",
        type: MockUtil().getRandom(ProjectType.values),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 90)),
        memberCount: MockUtil().getRandomNumber(1, 10),
      );
    }));
  }

  @override
  Future<UserWarningDetail> getUserWarningDetail() async {
    await MockUtil().applyMockSetting();

    return Future.value(UserWarningDetail(
      warningHistory: List.generate(
        MockUtil().getRandomNumber(0, 5),
        (index) {
          final type = MockUtil().getRandom(MemberWarningType.values);
          return UserWarningContent(
            warningType: type,
            desceiption: "테스트 $type",
            warningDate: DateTime.now(),
            warningPoint: MockUtil().getRandomDouble(0.5, 1.0, 0.5),
          );
        },
      ),
      warningReductionHistory: List.generate(
        MockUtil().getRandomNumber(0, 5),
        (index) {
          final type = MemberWarningType.deduction;
          return UserWarningContent(
            warningType: type,
            desceiption: "테스트 $type",
            warningDate: DateTime.now(),
            warningPoint: MockUtil().getRandomDouble(-2.0, -0.5, 0.5),
          );
        },
      ),
    ));
  }

  @override
  Future<void> logout() async {
    await MockUtil().applyMockSetting();
  }
}
