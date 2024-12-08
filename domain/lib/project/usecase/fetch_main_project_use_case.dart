import 'package:domain/project/repository/project_repository.dart';
import 'package:domain/project/value_objects/project_data.dart';
import 'package:get_it/get_it.dart';

class FetchMainProjectUseCase {
  final _projectRepository = GetIt.I.get<ProjectRepository>();

  Future<List<ProjectData>> call() {
    return _projectRepository.getMainProject();
  }
}
