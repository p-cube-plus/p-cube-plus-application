import 'package:flutter/material.dart';
import '../models/member.dart';
import '../services/project_api.dart';
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  late ProjectListApi _client;

  bool loaded = false;
  bool fail = false;

  late List<Project>? _projectList;
  List<Project>? get projectList => loaded ? _projectList : null;

  ProjectProvider() {
    initialize();
  }

  void initialize() {
    update();
  }

  Future<List<Project>?> _getProjects() async {
    //_client = ProjectListApi();
    //List<Project>? _projectList = await _client.getProjectList();
    List<Project>? _projectList = _getDummyProjects();

    return _projectList;
  }

  List<Project>? _getDummyProjects() {
    return <Project>[
      Project(
        id: 0,
        type: 0,
        name: "PCube+",
        isEnd: false,
        startDate: DateTime(2022, 05, 27),
        endDate: DateTime(2023, 01, 31),
        members: <Member>[
          Member(id: 0, name: "오창한", partIndex: 1),
          Member(id: 1, name: "권오민", partIndex: 1),
          Member(id: 2, name: "신혜민", partIndex: 0),
          Member(id: 3, name: "조승빈", partIndex: 1),
        ],
        pm: Member(id: 0, name: "오창한", partIndex: 1),
        platforms: <String>["Android"],
        tags: <String>["태그1", "태그2"],
      ),
      Project(
        id: 0,
        type: 0,
        name: "PCube+",
        isEnd: false,
        startDate: DateTime(2022, 05, 27),
        endDate: DateTime(2023, 01, 31),
        members: <Member>[
          Member(id: 0, name: "오창한", partIndex: 1),
          Member(id: 1, name: "권오민", partIndex: 1),
          Member(id: 2, name: "신혜민", partIndex: 0),
          Member(id: 3, name: "조승빈", partIndex: 1),
        ],
        pm: Member(id: 0, name: "오창한", partIndex: 1),
        platforms: <String>["Android"],
        tags: <String>[],
      ),
      Project(
        id: 0,
        type: 0,
        name: "PCube+",
        isEnd: false,
        startDate: DateTime(2022, 05, 27),
        endDate: DateTime(2023, 01, 31),
        members: <Member>[
          Member(id: 0, name: "오창한", partIndex: 1),
          Member(id: 1, name: "권오민", partIndex: 1),
          Member(id: 2, name: "신혜민", partIndex: 0),
          Member(id: 3, name: "조승빈", partIndex: 1),
        ],
        pm: Member(id: 0, name: "오창한", partIndex: 1),
        platforms: <String>["Android", "iOS"],
        tags: <String>["태그1", "태그2"],
      ),
      Project(
        id: 0,
        type: 1,
        name: "PCube+",
        isEnd: false,
        startDate: DateTime(2022, 05, 27),
        endDate: DateTime(2023, 01, 31),
        members: <Member>[
          Member(id: 0, name: "오창한", partIndex: 1),
          Member(id: 1, name: "권오민", partIndex: 1),
          Member(id: 2, name: "신혜민", partIndex: 0),
          Member(id: 3, name: "조승빈", partIndex: 1),
        ],
        pm: Member(id: 0, name: "오창한", partIndex: 1),
        platforms: <String>["Android", "PC"],
        tags: <String>["태그1", "태그2"],
      ),
    ];
  }

  Project? getProject({int? id, int? index}) {
    if (!loaded) return null;
    if (id == null && index == null) return null;
    if (index != null) return _projectList![index];

    var projects = _projectList!.where((e) => e.id == id);

    return projects.isEmpty ? null : projects.first;
  }

  void update() async {
    _projectList = await _getProjects();

    fail = _projectList == null;
    loaded = true;

    notifyListeners();
  }
}
