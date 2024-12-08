import 'package:domain/project/repository/project_repository.dart';
import 'package:domain/project/value_objects/project_detail_data.dart';
import 'package:get_it/get_it.dart';

class FetchProjectDetailUseCase {
  final _projectRepository = GetIt.I.get<ProjectRepository>();

  Future<ProjectDetailData> call(int projectId) {
    return _projectRepository.getProjectDetail(projectId);
  }
}
