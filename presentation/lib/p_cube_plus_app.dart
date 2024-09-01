import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/ui/splash/splash_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'ui/splash/splash_page.dart';

class PCubePlusApp extends StatelessWidget {
  final _getLightTheme = GetLightTheme();
  final _getDarkTheme = GetDarkTheme();

  PCubePlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    _setPortraitMode();
    _setStatusBarTransparent();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCube+',
      themeMode: ThemeMode.system,
      theme: _getLightTheme(),
      darkTheme: _getDarkTheme(),
      scrollBehavior: _RemoveScrollGlowEffect(),
      home: ChangeNotifierProvider(
        create: (_) => SplashPageViewModel(),
        child: const SplashPage(),
      ),
    );
  }

  void _setPortraitMode() {
    WidgetsFlutterBinding.ensureInitialized();
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

class _RemoveScrollGlowEffect extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
