import 'package:domain/project/repository/project_repository.dart';
import 'package:domain/project/value_objects/project_data.dart';
import 'package:domain/project/value_objects/project_detail_data.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  @override
  Future<List<ProjectData>> getMainProject() {
    // TODO: implement getMainProject
    throw UnimplementedError();
  }

  @override
  Future<List<ProjectData>> getTraineeProject() {
    // TODO: implement getTraineeProject
    throw UnimplementedError();
  }

  @override
  Future<ProjectDetailData> getProjectDetail(int projectId) {
    // TODO: implement getProjectDetail
    throw UnimplementedError();
  }
}
