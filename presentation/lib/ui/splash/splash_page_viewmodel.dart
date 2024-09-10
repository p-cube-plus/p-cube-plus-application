import 'package:domain/usecase/splash/fetch_initialize_cache_data_usecase.dart';
import 'package:domain/usecase/splash/fetch_is_need_login_usecase.dart';
import 'package:domain/usecase/splash/init_app_settings_usecase.dart';
import 'package:presentation/extensions/future_extension.dart';
import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/ui/splash/splash_state.dart';
import 'package:presentation/common/base_viewmodel.dart';

class SplashPageViewModel extends BaseViewModel<SplashState, SplashEvent> {
  final _initAppSettings = InitAppSettingsUseCase();
  final _fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  final _fetchInitialCacheData = FetchInitialCacheData();

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
    await _initAppSettings.call().catchError((error) {
      initErrorMessage = error.toString();
      changeState(SplashState.failedInit);
      return;
    });

    _isNeedLogin = await _fetchIsUserLoggedIn.call().getOrDefault(false);
    await _fetchInitialCacheData.call(_isNeedLogin).ignoreException();
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
