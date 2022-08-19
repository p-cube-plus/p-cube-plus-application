import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    backgroundColor: Color(0xFF242424),
    scaffoldBackgroundColor: Color(0xFF242424),
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2E2E2E),
      unselectedItemColor: Colors.white,
      selectedItemColor: const Color(0xFFDE2B13),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: const Color(0xFFFFFFFF)),
    ),
    fontFamily: "SpoqaHanSansNeo",
  );

  static final lightTheme = ThemeData(
    backgroundColor: Color(0xFFFBFBFB),
    scaffoldBackgroundColor: Color(0xFFFBFBFB),
    primaryColor: Colors.white,
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
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: const Color(0xFF000000)),
        side: BorderSide(
            width: 1, style: BorderStyle.solid, color: const Color(0xFFA9A9A9)),
        //backgroundColor: const Color(0xFFE9E9E9),
        primary: const Color(0xFFA9A9A9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(0, 35),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: const Color(0xFF2E2E2E)),
      headline2: TextStyle(color: const Color(0xFF818181)),
      headline3: TextStyle(color: const Color(0xFFABABAB)),
    ),
    fontFamily: "SpoqaHanSansNeo",
  );
}
