import 'package:domain/project/usecase/fetch_main_project_use_case.dart';
import 'package:domain/project/usecase/fetch_trainee_project_use_case.dart';
import 'package:domain/project/value_objects/project_data.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/project/project_event.dart';

class ProjectViewModel extends BaseViewModel<ProjectEvent> {
  final _fetchMainProjectUseCase = FetchMainProjectUseCase();
  final _fetchTraineeProjectUseCase = FetchTraineeProjectUseCase();

  Future<List<ProjectData>> fetchMainProject() =>
      _fetchMainProjectUseCase.call().onError(
        (error, trace) {
          triggerEvent(ProjectEvent.showDataErrorToast);
          return [];
        },
      );

  Future<List<ProjectData>> fetchTraineeProject() =>
      _fetchTraineeProjectUseCase.call().onError(
        (error, trace) {
          triggerEvent(ProjectEvent.showDataErrorToast);
          return [];
        },
      );
}
