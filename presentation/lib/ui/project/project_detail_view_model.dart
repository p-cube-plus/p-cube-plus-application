import 'package:domain/project/usecase/fetch_project_detail_use_case.dart';
import 'package:domain/project/value_objects/project_detail_data.dart';
import 'package:presentation/common/base_viewmodel.dart';

class ProjectDetailViewModel extends BaseViewModel<void, void> {
  final _fetchProjectDetailUseCase = FetchProjectDetailUseCase();

  final int projectId;

  ProjectDetailViewModel(this.projectId);

  Future<ProjectDetailData> fetchProjectDetail() =>
      _fetchProjectDetailUseCase.call(projectId);
}
