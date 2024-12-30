import 'package:domain/user/usecase/fetch_user_project_detail_use_case.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:presentation/common/base_viewmodel.dart';

class UserParticipatedProjectViewModel extends BaseViewModel<void> {
  final _fetchUserProjectDetailUseCase = FetchUserProjectDetailUseCase();

  Future<List<UserProjectDetail>> fetchUserProjectDetail() =>
      _fetchUserProjectDetailUseCase();
}
