import 'package:domain/models/project/project_data.dart';

abstract class ProjectService {
  Future<List<ProjectData>> getProject();
}
