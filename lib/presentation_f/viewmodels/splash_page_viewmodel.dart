import 'package:p_cube_plus_application/remote/utils/token_manager.dart';

class SplashPageViewModel {
  late bool _isNeedLogin;
  bool get isNeedLogin => _isNeedLogin;

  Future<void> checkIsNeedLogin() async {
    _isNeedLogin = !(await TokenManager().setTokenAndGetIsExistToken());
  }
}
