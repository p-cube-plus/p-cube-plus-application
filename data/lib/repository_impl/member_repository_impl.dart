import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:domain/member/repository/member_repository.dart';
import 'package:domain/member/value_objects/developer_member.dart';
import 'package:domain/member/value_objects/member_filter.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_selection.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:get_it/get_it.dart';

class MemberRepositoryImpl implements MemberRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();

  @override
  Future<List<MemberSelection>> getAllMemberList() {
    // TODO: API 필요
    throw UnimplementedError();
  }

  @override
  List<DeveloperMember> getDeveloperList() {
    return [
      DeveloperMember(
        name: "오창한",
        departmentName: "컴퓨터공학과",
        studentNumber: 18,
        partType: MemberPartType.development,
        positionType: GraduateMember(),
      ),
      DeveloperMember(
        name: "권오민",
        departmentName: "컴퓨터공학과",
        studentNumber: 20,
        partType: MemberPartType.development,
        positionType: DormantMember(),
      ),
      DeveloperMember(
        name: "신혜민",
        departmentName: "신문방송학과",
        studentNumber: 18,
        partType: MemberPartType.design,
        positionType: GraduateMember(),
      ),
      DeveloperMember(
        name: "정성희",
        departmentName: "컴퓨터공학과",
        studentNumber: 20,
        partType: MemberPartType.development,
        positionType: RegularMember(),
      ),
      DeveloperMember(
        name: "조승빈",
        departmentName: "컴퓨터공학과",
        studentNumber: 21,
        partType: MemberPartType.development,
        positionType: DormantMember(),
      ),
      DeveloperMember(
        name: "공도한",
        departmentName: "컴퓨터공학과",
        studentNumber: 19,
        partType: MemberPartType.development,
        positionType: RegularMember(),
      ),
      DeveloperMember(
        name: "전재원",
        departmentName: "컴퓨터공학과",
        studentNumber: 19,
        partType: MemberPartType.development,
        positionType: RegularMember(),
      ),
    ];
  }

  @override
  MemberFilter getMemberFilter() {
    return MemberFilter(
      isShowOnlyActiveMember:
          sharedPreferenceLocalDatasource.isShowOnlyActiveMember,
      memberNameSortType:
          SortType.values[sharedPreferenceLocalDatasource.memberNameSortType],
    );
  }

  @override
  void updateMemberFilter(MemberFilter filter) {
    sharedPreferenceLocalDatasource.isShowOnlyActiveMember =
        filter.isShowOnlyActiveMember;
    sharedPreferenceLocalDatasource.memberNameSortType =
        filter.memberNameSortType.index;
  }
}
