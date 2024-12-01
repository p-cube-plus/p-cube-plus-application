import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/app_view_model.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_page.dart';
import 'package:presentation/ui/home/home_page.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/user/user_setting/developer_setting_page/developer_page.dart';
import 'package:provider/provider.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'ui/splash/splash_page.dart';
import 'services/route_handler.dart' show navigatorKey;

class PCubePlusApp extends StatelessWidget {
  const PCubePlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    _setPortraitMode();
    _setStatusBarTransparent();
    return ChangeNotifierProvider(
      create: (_) => AppViewModel(),
      child: _PCubePlusApp(),
    );
  }

  void _setPortraitMode() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
  }

  void _setStatusBarTransparent() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
    ));
  }
}

class _PCubePlusApp extends StatelessWidget with ViewModel<AppViewModel> {
  final _getLightTheme = GetLightTheme();
  final _getDarkTheme = GetDarkTheme();

  @override
  Widget build(BuildContext context) {
    return watchWidget((viewModel) => viewModel.currentThemeMode,
        (context, currentThemeMode) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PCube+',
        themeMode: currentThemeMode,
        theme: _getLightTheme(),
        darkTheme: _getDarkTheme(),
        scrollBehavior: _RemoveScrollGlowEffect(),
        navigatorKey: navigatorKey,
        home: SplashPage(),
        routes: {
          // "/": (context) => SplashPage(),
          "/login": (context) => LoginHomePage(),
          "/developer": (context) => DeveloperPage(),
          "/user": (context) => LoginHomePage(),
          "/alarm": (context) => ExecutiveAlarmPage(),
        },
      );
    });
  }
}

class _RemoveScrollGlowEffect extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}



  //  Navigator.of(context).push(
  //          MaterialPageRoute(
  //          settings: RouteSettings(name: "/Page1"),
  //          builder: (context) => Page1(),
	// 	),
  //  );

  // Navigator.of(context).pushNamed(LoginViewRoute, arguments: 'Data Passed in');

    //  Navigator.of(context)
    //           .popUntil(ModalRoute.withName("/Page1"));