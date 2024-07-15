import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cube_plus_application/local/shared_preferences_util.dart';
import 'package:p_cube_plus_application/presentation/screens/splash_page/splash_page.dart';
import 'package:p_cube_plus_application/common/utils/theme.dart';
import 'package:provider/provider.dart';

import 'presentation/models/auth_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var themeMode = await SharedPreferencesUtil().getThemeMode();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthModel()),
    ],
    child: AppStartWidget(themeMode),
  ));
}

class AppStartWidget extends StatelessWidget {
  final theme;
  const AppStartWidget(this.theme);

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
