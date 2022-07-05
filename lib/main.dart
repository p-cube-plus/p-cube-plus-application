import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:p_cube_plus_application/widgets/setting_list_widget.dart';
import 'package:provider/provider.dart';

import 'providers/notice_list.dart';

import 'screens/login_page.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 이후, 앱 시작 시 필요한 정보나 요청을 다 받고
  // FlutterNativeSplash.remove();

  //WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoticeList()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCube+', // 탭 이름
      themeMode: ThemeMode.system, // 시스템에 따라 모드 변경
      home: LoginPage(),
    );
  }
}
