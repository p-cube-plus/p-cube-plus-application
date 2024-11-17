import 'package:domain/user/usecase/fetch_user_warning_detail_use_case.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';
import 'package:presentation/common/base_viewmodel.dart';

class UserWarningViewModel extends BaseViewModel<void, void> {
  final _fetchUserWarningDetailUseCase = FetchUserWarningDetailUseCase();

  Future<UserWarningDetail> fetchUserWarningDetail() =>
      _fetchUserWarningDetailUseCase();
}
