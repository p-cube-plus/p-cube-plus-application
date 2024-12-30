import 'package:data/common/memory_cache.dart';
import 'package:data/utils/mock_util.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/project/repository/project_repository.dart';
import 'package:domain/project/value_objects/project_data.dart';
import 'package:domain/project/value_objects/project_detail_data.dart';
import 'package:domain/project/value_objects/project_detail_member_data.dart';
import 'package:domain/project/value_objects/project_role_tag.dart';
import 'package:domain/project/value_objects/project_type.dart';

class MockProjectRepositoryImpl implements ProjectRepository {
  MemoryCache<List<ProjectData>> projectList =
      MemoryCache(Duration(minutes: 5));

  Future<List<ProjectData>> _getProjectList() async {
    return projectList.fetchOrCache(() async {
      return List.generate(MockUtil().getRandomNumber(20, 30), (index) {
        final startDate = MockUtil().getRandomDateTime(
            DateTime.now().subtract(Duration(days: 30)), DateTime.now());
        final endDate = MockUtil().getRandomBool()
            ? null
            : MockUtil().getRandomDateTime(
                startDate, startDate.add(Duration(days: 30)));
        return ProjectData(
          projectId: index,
          title: "프로젝트 $index",
          type: MockUtil().getRandom([ProjectType.main, ProjectType.trainee]),
          startDate: startDate,
          endDate: endDate,
          memberCount: MockUtil().getRandomNumber(1, 10),
          isFindingMember: endDate?.isBefore(DateTime.now()) == true
              ? false
              : MockUtil().getRandomBool(),
        );
      });
    });
  }

  @override
  Future<List<ProjectData>> getMainProject() async {
    await MockUtil().applyMockSetting();

    final projectList = await _getProjectList();
    return projectList
        .where((value) => value.type == ProjectType.main)
        .toList();
  }

  @override
  Future<ProjectDetailData> getProjectDetail(int projectId) async {
    await MockUtil().applyMockSetting();

    final projectList = await _getProjectList();
    final targetProject =
        projectList.firstWhere((value) => value.projectId == projectId);
    await Future.delayed(Duration(seconds: 1));
    return ProjectDetailData(
      projectId: projectId,
      title: targetProject.title,
      platformType: MockUtil().getRandom(["PC", "모바일", "캐주얼"]),
      graphicType: MockUtil().getRandom(["PC", "모바일", "캐주얼"]),
      type: targetProject.type,
      startDate: targetProject.startDate,
      endDate: targetProject.endDate,
      isFindingMember: targetProject.isFindingMember,
      memberList: List.generate(targetProject.memberCount, (index) {
        return ProjectDetailMemberData(
          memberId: index,
          name: MockUtil().getRandomKoreanName(),
          memberPartType: MockUtil().getRandom(MemberPartType.values),
          projectRoleTags: List.generate(index == 0 ? 2 : 1, (index2) {
            if (index == 0 && index2 == 0) {
              return ProjectRoleTag(role: "PM", isProjectLead: true);
            }
            return ProjectRoleTag(
                role: MockUtil().getRandom([
                  "프로그래밍",
                  "몬스터/전투 기획",
                  "맵/레벨 디자인",
                  "UI/UX",
                  "배경 디자인",
                  "인물 디자인"
                ]),
                isProjectLead: false);
          }),
        );
      }),
    );
  }

  @override
  Future<List<ProjectData>> getTraineeProject() async {
    await MockUtil().applyMockSetting();

    final projectList = await _getProjectList();
    return projectList
        .where((value) => value.type == ProjectType.trainee)
        .toList();
  }
}
