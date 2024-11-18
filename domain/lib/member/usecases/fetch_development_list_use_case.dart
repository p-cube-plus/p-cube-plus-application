import 'package:domain/member/value_objects/developer_member.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_position_type.dart';

class FetchDevelopmentListUseCase {
  List<DeveloperMember> call() {
    return [
      DeveloperMember(
        name: "오창한",
        departmentName: "컴퓨터공학과",
        studentNumber: 18,
        partType: MemberPartType.development,
        positionType: GraduatingMember(),
      ),
      DeveloperMember(
        name: "권오민",
        departmentName: "컴퓨터공학과",
        studentNumber: 20,
        partType: MemberPartType.development,
        positionType: HonoraryMember(),
      ),
      DeveloperMember(
        name: "신혜민",
        departmentName: "신문방송학과",
        studentNumber: 18,
        partType: MemberPartType.design,
        positionType: GraduatingMember(),
      ),
      DeveloperMember(
        name: "정성희",
        departmentName: "컴퓨터공학과",
        studentNumber: 20,
        partType: MemberPartType.development,
        positionType: GraduatingMember(),
      ),
      DeveloperMember(
        name: "조승빈",
        departmentName: "컴퓨터공학과",
        studentNumber: 21,
        partType: MemberPartType.development,
        positionType: RegularMember(),
      ),
      DeveloperMember(
        name: "공도한",
        departmentName: "컴퓨터공학과",
        studentNumber: 19,
        partType: MemberPartType.development,
        positionType: GraduatingMember(),
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
}
