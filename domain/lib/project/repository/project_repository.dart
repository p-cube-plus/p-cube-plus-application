import 'package:domain/project/models/project_data.dart';

abstract interface class ProjectRepository {
  Future<List<ProjectData>> getProject();
}
