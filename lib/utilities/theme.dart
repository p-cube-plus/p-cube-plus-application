import 'package:flutter/material.dart';

class MyThemes {
  static const Color primary80 = Color(0xCCDE2B13);
  static const Color primary60 = Color(0x99DE2B13);
  static const Color primary40 = Color(0x66DE2B13);
  static const Color primary20 = Color(0x33DE2B13);
  static const Color primary10 = Color(0x1ADE2B13);

  static const Color secondary100 = Color(0xFF25CA85);
  static const Color secondary20 = Color(0x3325CA85);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFE55542),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    dialogBackgroundColor: const Color(0xFFE9E9E9),
    cardColor: const Color(0xFFFFFFFF),
    dividerColor: const Color(0xFFE9E9E9),
    disabledColor: const Color(0xFFE8E8E8),
    shadowColor: const Color(0x0A000000),
    fontFamily: "SpoqaHanSansNeo",
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: const Color(0xFF2E2E2E)),
      displayMedium: TextStyle(color: const Color(0xFF818181)),
      displaySmall: TextStyle(color: const Color(0xFFABABAB)),
      headlineMedium: TextStyle(color: const Color(0xFFFFFFFF)),
      headlineSmall: TextStyle(color: const Color(0xFF575757)),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: const Color(0xFF2E2E2E),
      labelStyle: const TextStyle(
        color: const Color(0xFF2E2E2E),
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        color: const Color(0xFFABABAB),
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      unselectedItemColor: const Color(0xFF2E2E2E),
      selectedItemColor: const Color(0xFFE45441),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE45441),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        minimumSize: const Size(0.0, 35.0),
        textStyle: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFFFFF), side: const BorderSide(width: 0.0, style: BorderStyle.none),
        backgroundColor: const Color(0xFFE9E9E9),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        minimumSize: const Size(0.0, 35.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF2E2E2E), splashFactory: NoSplash.splashFactory,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    )),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: const Color(0xFFE45441),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: const Color(0xCCE45441),
      cursorColor: const Color(0xCCE45441),
      selectionHandleColor: const Color(0xCCE45441),
    ), colorScheme: const ColorScheme.light().copyWith(background: const Color(0xFFFBFBFB)),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFBA2916),
    scaffoldBackgroundColor: const Color(0xFF2E2E2E),
    dialogBackgroundColor: const Color(0xFF3B3B3B),
    cardColor: const Color(0xFF2E2E2E),
    dividerColor: const Color(0xFFC9C9C9),
    disabledColor: const Color(0xFF1E1E1E),
    shadowColor: const Color(0x0A000000),
    fontFamily: "SpoqaHanSansNeo",
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: const Color(0xFFFFFFFF)),
      displayMedium: TextStyle(color: const Color(0xFFBCBCBC)),
      displaySmall: TextStyle(color: const Color(0xFF979797)),
      headlineMedium: TextStyle(color: const Color(0xFF000000)),
      headlineSmall: TextStyle(color: const Color(0xFFA5A5A5)),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: const Color(0xFFFBFBFB),
      labelStyle: const TextStyle(
          color: const Color(0xFFFBFBFB),
          fontSize: 16.0,
          fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(
        color: const Color(0xFFE9E9E9),
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF2E2E2E),
        unselectedItemColor: const Color(0xFFFFFFFF),
        selectedItemColor: const Color(0xFFBA2916)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBA2916),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          textStyle: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFFFFFF))),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF101010), side: const BorderSide(width: 0.0, style: BorderStyle.none),
        backgroundColor: const Color(0xFF202020),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        minimumSize: const Size(0.0, 35.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFFBFBFB), splashFactory: NoSplash.splashFactory,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: const Color(0xFFBA2916),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: const Color(0xCCE45441),
      cursorColor: const Color(0xCCE45441),
      selectionHandleColor: const Color(0xCCBA2916),
    ), colorScheme: const ColorScheme.dark().copyWith(background: const Color(0xFF242424)),
  );
}
