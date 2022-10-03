import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    backgroundColor: Color(0xFF242424),
    scaffoldBackgroundColor: Color(0xFF2E2E2E),
    dialogBackgroundColor: Color(0xFF3B3B3B),
    primaryColor: Colors.black,
    cardColor: Color(0xFF2E2E2E),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.white.withAlpha(127),
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2E2E2E),
      unselectedItemColor: Colors.white,
      selectedItemColor: const Color(0xFFDE2B13),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        primary: const Color(0xFFDE2B13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(0, 35),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        side: BorderSide(width: 0, style: BorderStyle.none),
        backgroundColor: const Color(0xFF202020),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(0, 35),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: const Color(0xFFFFFFFF)),
      headline2: TextStyle(color: Colors.white70),
      headline3: TextStyle(color: Colors.white54),
      headline4: TextStyle(color: const Color(0xFF000000)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color(0xFFDE2B13),
    ),
    fontFamily: "SpoqaHanSansNeo",
  );

  static final lightTheme = ThemeData(
    backgroundColor: Color(0xFFFBFBFB),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    dialogBackgroundColor: Color(0xFFE9E9E9),
    primaryColor: Colors.white,
    cardColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelColor: const Color(0xFF2E2E2E),
      labelStyle: TextStyle(
        color: const Color(0xFF2E2E2E),
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        color: const Color(0xFFABABAB),
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black87, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Color(0xFF2E2E2E),
      selectedItemColor: const Color(0xCCDE2B13),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        primary: const Color(0xFFDE2B13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(0, 35),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(width: 0, style: BorderStyle.none),
        backgroundColor: const Color(0xFFE9E9E9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(0, 35),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: const Color(0xFF2E2E2E)),
      headline2: TextStyle(color: const Color(0xFF818181)),
      headline3: TextStyle(color: const Color(0xFFABABAB)),
      headline4: TextStyle(color: const Color(0xFFFFFFFF)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color(0xFFDE2B13),
    ),
    fontFamily: "SpoqaHanSansNeo",
  );
}
