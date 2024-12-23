import 'package:domain/login/usecases/logout_use_case.dart';
import 'package:domain/member/usecases/fetch_development_list_use_case.dart';
import 'package:domain/member/value_objects/developer_member.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/user/user_setting/user_setting_event.dart';

class UserSettingViewModel extends BaseViewModel<void, UserSettingEvent> {
  final _fetchDevelopmentListUseCase = FetchDevelopmentListUseCase();
  final _logoutUseCase = LogoutUseCase();

  List<DeveloperMember> fetchDevelopmentList() =>
      _fetchDevelopmentListUseCase.call();

  void logout() {
    _logoutUseCase.call().then((_) {
      triggerUiEvent(OnSuccessLogoutEvent());
    });
  }
}
