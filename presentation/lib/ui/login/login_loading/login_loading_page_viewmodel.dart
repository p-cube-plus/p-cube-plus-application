import 'package:domain/login/usecases/try_login_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/login/login_loading/login_loading_state.dart';

class LoginLoadingPageViewModel extends BaseViewModel<LoginLoadingState> {
  final _tryLoginUseCase = TryLoginUseCase();
  var errorMessage = "";

  final String _phoneNumber;
  final String _userName;

  LoginLoadingPageViewModel(String phoneNumber, String userName)
      : _phoneNumber = phoneNumber,
        _userName = userName {
    tryLogin(_userName);
  }

  void tryLogin(String userName) {
    _tryLoginUseCase(_phoneNumber, userName).then((isSuccess) {
      if (isSuccess) {
        triggerEvent(LoginLoadingState.successLogin);
      } else {
        triggerEvent(LoginLoadingState.failedLogin);
      }
    }).onError((error, stackTrace) {
      errorMessage = "조회 중 오류가 발생했습니다. $error";
      triggerEvent(LoginLoadingState.errorLogin);
    });
  }
}
