import 'package:data/models/remote/project/project_dto.dart';

abstract class ProjectService {
  Future<List<ProjectDTO>> getProject();
}
