import 'package:domain/project/value_objects/project_data.dart';
import 'package:domain/project/value_objects/project_detail_data.dart';

abstract interface class ProjectRepository {
  Future<List<ProjectData>> getMainProject();
  Future<List<ProjectData>> getTraineeProject();
  Future<ProjectDetailData> getProjectDetail(int projectId);
}
