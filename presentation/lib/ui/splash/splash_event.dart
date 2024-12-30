sealed class SplashEvent {}

class SplashEventFailedInit implements SplashEvent {
  final String errorMessage;
  SplashEventFailedInit(this.errorMessage);
}

class SplashEventNavigateToMainPage implements SplashEvent {}

class SplashEventNavigateToLoginPage implements SplashEvent {}
