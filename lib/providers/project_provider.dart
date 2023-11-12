import '../models/member.dart';
import '../models/project.dart';
import 'base/provider_base.dart';

class ProjectProvider extends DummyProviderBase<List<Project>> {
  List<Project> getProjectListByType(int type) {
    return data.where((e) => e.type == type).toList();
  }

  Project? getProjectById(int id) {
    return data.firstWhere((e) => e.id == id);
  }

  Project? getProjectByIndex(int index) {
    if (index >= 0 && index < data.length) {
      return data[index];
    } else {
      return null;
    }
  }

  @override
  List<Project> getDummy({Object? parameter}) {
    return <Project>[
      Project(
        id: 0,
        type: 0,
        name: "PCube+",
        status: 2,
        startDate: DateTime(2022, 05, 27),
        endDate: DateTime(2023, 01, 31),
        members: <Member>[
          Member(
              id: 0,
              isSigned: true,
              name: "오창한",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 1,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "신혜민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 3,
              isSigned: true,
              name: "조승빈",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 3,
              isSigned: true,
              name: "정성희",
              level: 1,
              partIdx: 1,
              profileImage: null),
        ],
        pm: Member(
            id: 0,
            isSigned: true,
            name: "오창한",
            level: 1,
            partIdx: 1,
            profileImage: null),
        platforms: <String>["Android"],
        graphic: "2D",
        isFindingMember: false,
        isAbleInquiry: true,
      ),
      Project(
        id: 0,
        type: 0,
        name: "괴담프로젝트",
        status: 2,
        startDate: DateTime(2023, 09, 28),
        endDate: null,
        members: <Member>[
          Member(
              id: 0,
              isSigned: true,
              name: "서명교",
              level: 1,
              partIdx: 0,
              profileImage: null),
          Member(
              id: 1,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 0,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "김도엽",
              level: 1,
              partIdx: 1,
              profileImage: null),
        ],
        pm: Member(
            id: 0,
            isSigned: true,
            name: "서명교",
            level: 1,
            partIdx: 1,
            profileImage: null),
        platforms: <String>["PC", "Unreal"],
        graphic: "3D",
        isFindingMember: false,
        isAbleInquiry: true,
      ),
      Project(
        id: 1,
        type: 1,
        name: "권오민복사버그",
        status: 1,
        startDate: DateTime(2023, 09, 28),
        endDate: null,
        members: <Member>[
          Member(
              id: 0,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 0,
              profileImage: null),
          Member(
              id: 1,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 2,
              profileImage: null),
        ],
        pm: Member(
            id: 0,
            isSigned: true,
            name: "권오민",
            level: 1,
            partIdx: 1,
            profileImage: null),
        platforms: <String>["PC", "Unreal"],
        graphic: "2.5D",
        isFindingMember: false,
        isAbleInquiry: true,
      ),
    ];
  }
}
