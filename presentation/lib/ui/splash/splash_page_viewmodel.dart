import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/common/base_viewmodel.dart';

/// 스플래시가 항상 보여주게 변경 시 주석 해제
/// 현재 요구사항: 로그인 시에만 스플래시 보여주게

class SplashPageViewModel extends BaseViewModel<SplashEvent> {
  // final _fetchIsUserLoggedIn = FetchIsNeedLoginUseCase();
  // final _cachingBeforeStartingUseCase = CachingBeforeStartingUseCase();
  // late Future<void> _initializeFuture;
  // bool _isLoggedIn = false;
  // bool _isError = true;

  SplashPageViewModel() {
    // _initializeFuture = _initializeApp().catchError((e) {
    //   _isError = true;
    //   triggerEvent(SplashEventFailedInit(e.toString()));
    //   return;
    // });
  }

  // Future<void> _initializeApp() async {
  //   _isLoggedIn = await _fetchIsUserLoggedIn.call().getOrDefault(false);
  //   await PushNotificationManager().initialize().getOrThrow();
  //   await _cachingBeforeStartingUseCase.call(_isLoggedIn).getOrThrow();
  // }

  Future<void> changeStateBasedOnLogin() async {
    // await _initializeFuture;
    // if (_isError) return;

    // if (_isLoggedIn) {
    //   triggerEvent(SplashEventNavigateToMainPage());
    // } else {
    //   triggerEvent(SplashEventNavigateToLoginPage());
    // }

    triggerEvent(SplashEventNavigateToLoginPage());
  }
}
