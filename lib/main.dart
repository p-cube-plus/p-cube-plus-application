import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:p_cube_plus_application/widgets/setting_list_widget.dart';
import 'package:provider/provider.dart';

import 'providers/notice_list.dart';

import 'screens/login_page.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 이후, 앱 시작 시 필요한 정보나 요청을 다 받고
  // FlutterNativeSplash.remove();

  WidgetsFlutterBinding.ensureInitialized();

  await Settings.init(cacheProvider: SharePreferenceCache());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoticeList()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueChangeObserver<bool>(
      cacheKey: DarkMode.keyDarkMode,
      defaultValue: true,
      builder: (_, isDarkMode, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PCube+', // 탭 이름
        themeMode: ThemeMode.system, // 시스템에 따라 모드 변경
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
                brightness: Brightness.dark,
                //colorScheme: ColorScheme.dark()
                //    .copyWith(primary: const Color(0xFF242424)),
                backgroundColor: Color(0xFF242424),
                scaffoldBackgroundColor: Color(0xFF242424),
                canvasColor: Color(0xFF242424),
                //primaryTextTheme:
                //    Typography(platform: TargetPlatform.iOS).white,
                //textTheme: Typography(platform: TargetPlatform.iOS).white,
              )
            : ThemeData.light().copyWith(
                colorScheme: ColorScheme.light().copyWith(
                  primary: Color.fromARGB(255, 107, 107, 107),
                ), // 상단
                scaffoldBackgroundColor: Color(0xFFF4F4F4), // 배경
                canvasColor: Color(0xFFFFFFFF), // 하단
                textTheme: TextTheme(
                  bodyText1: TextStyle(),
                  bodyText2: TextStyle(),
                ).apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.blue,
                ),
                primaryColor: const Color.fromARGB(255, 222, 43, 19),
                backgroundColor: const Color.fromARGB(255, 245, 245, 245),
              ),
        home: LoginPage(),
      ),
    );
  }
}
