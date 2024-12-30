import 'package:domain/project/usecase/fetch_main_project_use_case.dart';
import 'package:domain/project/usecase/fetch_trainee_project_use_case.dart';
import 'package:domain/project/value_objects/project_data.dart';
import 'package:presentation/common/base_viewmodel.dart';

class ProjectViewModel extends BaseViewModel<void> {
  final _fetchMainProjectUseCase = FetchMainProjectUseCase();
  final _fetchTraineeProjectUseCase = FetchTraineeProjectUseCase();

  Future<List<ProjectData>> fetchMainProject() =>
      _fetchMainProjectUseCase.call();

  Future<List<ProjectData>> fetchTraineeProject() =>
      _fetchTraineeProjectUseCase.call();
}
