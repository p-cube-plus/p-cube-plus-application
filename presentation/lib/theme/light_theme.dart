import 'package:flutter/material.dart';

class GetLightTheme {
  ThemeData call() => ThemeData(
        brightness: Brightness.light,
        fontFamily: "SpoqaHanSansNeo",
        colorScheme: const ColorScheme.light(
          surface: Color(0xFFFBFBFB),
        ),
        // tabBarTheme: const TabBarTheme(
        //   labelColor: const Color(0xFF2E2E2E),
        //   labelStyle: const TextStyle(
        //     color: const Color(0xFF2E2E2E),
        //     fontSize: 16.0,
        //     fontWeight: FontWeight.w700,
        //   ),
        //   unselectedLabelStyle: const TextStyle(
        //     color: const Color(0xFFABABAB),
        //     fontSize: 16.0,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFFFFFFF),
          unselectedItemColor: Color(0xFF2E2E2E),
          selectedItemColor: Color(0xFFE45441),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xFFE9E9E9);
                  }
                  return const Color(0xFFE45441);
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xFFABABAB);
                  }
                  return const Color(0xFFFFFFFF);
                },
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              minimumSize: WidgetStateProperty.all<Size>(
                const Size(0.0, 35.0),
              ),
              textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return const TextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: 16,
                      fontWeight: FontWeight.w700);
                }
                return const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w700);
              })),
        ),
        // outlinedButtonTheme: OutlinedButtonThemeData(
        //   style: OutlinedButton.styleFrom(
        //     foregroundColor: const Color(0xFFFFFF),
        //     side: const BorderSide(width: 0.0, style: BorderStyle.none),
        //     backgroundColor: const Color(0xFFE9E9E9),
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0)),
        //     minimumSize: const Size(0.0, 35.0),
        //   ),
        // ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF2E2E2E),
          splashFactory: NoSplash.splashFactory,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFE45441),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0xCCE45441),
          cursorColor: Color(0xCCE45441),
          selectionHandleColor: Color(0xCCE45441),
        ),
      );
}
