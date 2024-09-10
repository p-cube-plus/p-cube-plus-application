import 'package:domain/project/models/project_data.dart';

abstract class ProjectRepository {
  Future<List<ProjectData>> getProject();
}
