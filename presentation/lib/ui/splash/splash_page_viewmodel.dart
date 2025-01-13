import 'package:domain/app_configuration/usecases/caching_before_starting_use_case.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/login/usecases/fetch_is_need_login_use_case.dart';
import 'package:presentation/push_notification/push_notification_manager.dart';
import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/common/base_viewmodel.dart';

class SplashPageViewModel extends BaseViewModel<SplashEvent> {
  final _fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  final _cachingBeforeStartingUseCase = CachingBeforeStartingUseCase();
  late Future<void> _initializeFuture;
  bool _isLoggedIn = false;
  bool _isError = false;

  SplashPageViewModel() {
    _initializeFuture = _initializeApp().catchError((e) {
      _isError = true;
      triggerEvent(SplashEventFailedInit(e.toString()));
      return;
    });
  }

  Future<void> _initializeApp() async {
    _isLoggedIn = await _fetchIsUserLoggedIn.call().getOrDefault(false);
    await PushNotificationManager().initialize().getOrThrow();
    await _cachingBeforeStartingUseCase.call(_isLoggedIn).getOrNull();
  }

  Future<void> changeStateBasedOnLogin() async {
    await _initializeFuture;
    if (_isError) return;

    if (_isLoggedIn) {
      triggerEvent(SplashEventNavigateToMainPage());
    } else {
      triggerEvent(SplashEventNavigateToLoginPage());
    }
  }
}
