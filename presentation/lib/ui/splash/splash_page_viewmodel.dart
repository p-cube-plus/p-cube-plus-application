import 'package:domain/app_configuration/usecases/caching_before_starting_use_case.dart';
import 'package:domain/app_configuration/usecases/initialize_app_configuration_use_case.dart';
import 'package:domain/login/usecases/fetch_is_need_login_use_case.dart';
import 'package:presentation/extensions/future_extension.dart';
import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/ui/splash/splash_state.dart';
import 'package:presentation/common/base_viewmodel.dart';

class SplashPageViewModel extends BaseViewModel<SplashState, SplashEvent> {
  final _initializeAppConfigurationUseCase =
      InitializeAppConfigurationUseCase();
  final _fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  final _cachingBeforeStartingUseCase = CachingBeforeStartingUseCase();

  bool _isNeedLogin = true;
  late Future<void> _initFuture;
  String? initErrorMessage;

  SplashPageViewModel() {
    _setEventListener();
    _initFuture = _init();
  }

  void _setEventListener() {
    userActionEventStream.listen((event) {
      switch (event) {
        case SplashEvent.animationComplete:
          _changeStateBasedOnLogin();
      }
    });
  }

  Future<void> _init() async {
    await _initializeAppConfigurationUseCase.call().catchError((error) {
      initErrorMessage = error.toString();
      changeState(SplashState.failedInit);
      return;
    });

    _isNeedLogin = await _fetchIsUserLoggedIn.call().getOrDefault(false);
    await _cachingBeforeStartingUseCase.call(_isNeedLogin).ignoreException();
  }

  Future<void> _changeStateBasedOnLogin() async {
    if (initErrorMessage != null) return;

    await _initFuture;
    if (_isNeedLogin) {
      changeState(SplashState.needLogin);
    } else {
      changeState(SplashState.loginSuccess);
    }
  }
}
