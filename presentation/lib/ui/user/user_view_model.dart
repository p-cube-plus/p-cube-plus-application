import 'package:domain/user/usecase/fetch_user_profile_use_case.dart';
import 'package:domain/user/usecase/fetch_user_project_use_case.dart';
import 'package:domain/user/usecase/fetch_user_warning_use_case.dart';
import 'package:domain/user/value_objects/user_profile.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:presentation/common/base_viewmodel.dart';

class UserViewModel extends BaseViewModel<void, void> {
  final _fetchUserProfileUseCase = FetchUserProfileUseCase();
  final _fetchUserWarningUseCase = FetchUserWarningUseCase();
  final _fetchUserProjectUseCase = FetchUserProjectUseCase();

  Future<UserProfile> fetchUserProfile() => _fetchUserProfileUseCase();
  Future<UserWarning> fetchUserWarning() => _fetchUserWarningUseCase();
  Future<List<UserProject>> fetchUserProject() => _fetchUserProjectUseCase();
}
