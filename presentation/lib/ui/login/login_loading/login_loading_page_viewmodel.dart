import 'package:domain/usecase/login/try_login_usecase.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/login/login_loading/login_loading_state.dart';

class LoginLoadingPageViewModel extends BaseViewModel<LoginLoadingState, void> {
  final _tryLogin = TryLoginUseCase();
  var errorMessage = "";

  final String _phoneNumber;
  final String _userName;

  LoginLoadingPageViewModel(String phoneNumber, String userName)
      : _phoneNumber = phoneNumber,
        _userName = userName {
    tryLogin(_userName);
  }

  void tryLogin(String userName) {
    _tryLogin(_phoneNumber, userName).then((isSuccess) {
      if (isSuccess) {
        changeState(LoginLoadingState.successLogin);
      } else {
        changeState(LoginLoadingState.failedLogin);
      }
    }).onError((error, stackTrace) {
      errorMessage = "조회 중 오류가 발생했습니다. $error";
      changeState(LoginLoadingState.errorLogin);
    });
  }
}
