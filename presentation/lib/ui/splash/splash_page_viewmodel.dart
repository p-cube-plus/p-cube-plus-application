import 'package:domain/app_configuration/usecases/caching_before_starting_use_case.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/login/usecases/fetch_is_need_login_use_case.dart';
import 'package:presentation/push_notification/push_notification_manager.dart';
import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/ui/splash/splash_state.dart';
import 'package:presentation/common/base_viewmodel.dart';

class SplashPageViewModel extends BaseViewModel<SplashState> {
  final _fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  final _cachingBeforeStartingUseCase = CachingBeforeStartingUseCase();

  bool _isLoggedIn = false;
  late Future<void> _initializeFuture;
  String? initErrorMessage;

  SplashPageViewModel() {
    _initializeFuture = _initializeApp();
  }

  Future<void> _initializeApp() async {
    _isLoggedIn = await _fetchIsUserLoggedIn.call().getOrDefault(false);
    await Future.wait([
      _cachingBeforeStartingUseCase.call(_isLoggedIn),
      PushNotificationManager().initialize(),
    ]);
  }

  Future<void> changeStateBasedOnLogin() async {
    if (initErrorMessage != null) return;

    await _initializeFuture;
    if (_isLoggedIn) {
      triggerEvent(SplashState.loginSuccess);
    } else {
      triggerEvent(SplashState.needLogin);
    }
  }
}
