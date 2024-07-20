import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cube_plus_application/presentation_f/screens/splash_page/splash_page.dart';
import 'package:provider/provider.dart';
import 'presentation_f/models/auth_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      // SettingModel
      ChangeNotifierProvider(create: (context) => AuthModel()),
    ],
    child: AppStartWidget(),
  ));
}

class AppStartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _setStatusBarTransparent();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCube+',
      themeMode: theme,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      scrollBehavior: _RemoveScrollGlowEffect(),
      home: SplashPage(),
    );
  }

  void _setStatusBarTransparent() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
