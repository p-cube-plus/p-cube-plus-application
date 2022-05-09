import 'package:flutter/material.dart';

import 'screens/notice_page.dart';
import 'screens/login_page.dart';

// futter 에서 최상위에 위치하는 widget 인 runApp()은
// 항상 Widget tree의 root가 되는 widget을 가져와야 함
void main() => runApp(MyApp());


// 최상위 root Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp: 실질적으로 모든 위젯을 감싸는 위젯
    return MaterialApp(
      title: 'PCube+', // 탭 이름
      themeMode: ThemeMode.system, // 시스템에 따라 모드 변경
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: LoginPage(), // home: App 이 정상적으로 실행되었을 때 보여주는 경로
    );
  }
}
