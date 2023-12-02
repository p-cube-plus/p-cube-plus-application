import 'package:flutter/material.dart';
import '../services/project_api.dart';
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  ProjectApi _projectListApi = new ProjectApi();
  List<Project>? _projectList;
  List<Project>? get projectList => _projectList;

  Future<List<Project>?> update() async {
    _projectList = await _projectListApi.getProjects();
    notifyListeners();
    return _projectList;
  }

  Future<List<Project>?> getProjectListByType(int type) async {
    if (_projectList == null) await update();
    return _projectList?.where((e) => e.type == type).toList();
  }

  Project? getProjectById(int id) {
    return _projectList?.firstWhere((e) => e.id == id);
  }

  Project? getProjectByIndex(int index) {
    if (index >= 0 && index < _projectList!.length) {
      return _projectList![index];
    } else {
      return null;
    }
  }
}
