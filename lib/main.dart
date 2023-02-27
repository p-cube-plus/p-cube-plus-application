import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cube_plus_application/providers/fee_provider.dart';
import 'package:p_cube_plus_application/providers/naver_login.dart';
import 'package:p_cube_plus_application/providers/project_provider.dart';
import 'package:p_cube_plus_application/providers/rent_provider.dart';
import 'package:p_cube_plus_application/providers/schedule_provider.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:p_cube_plus_application/providers/theme_provider.dart';
import 'package:p_cube_plus_application/providers/user_data_provider.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:provider/provider.dart';

import 'providers/notice_provider.dart';

import 'screens/login_page.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => NaverLoginProvider()),
      ChangeNotifierProvider(create: (_) => FeeProvider()),
      ChangeNotifierProvider(create: (_) => NoticeProvider()),
      ChangeNotifierProvider(create: (_) => ProjectProvider()),
      ChangeNotifierProvider(create: (_) => RentProvider()),
      ChangeNotifierProvider(create: (_) => ScheduleProvider()),
      ChangeNotifierProvider(create: (_) => SettingProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Status Bar 투명하게
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCube+', // 탭 이름
      themeMode: themeProvider.type,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: LoginPage(),
    );
  }
}
