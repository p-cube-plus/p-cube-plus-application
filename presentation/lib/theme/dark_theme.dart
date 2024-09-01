import 'package:flutter/material.dart';

class GetDarkTheme {
  ThemeData call() => ThemeData(
        brightness: Brightness.dark,
        fontFamily: "SpoqaHanSansNeo",
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF242424),
        ),
        // tabBarTheme: TabBarTheme(
        //   labelColor: const Color(0xFFFBFBFB),
        //   labelStyle: const TextStyle(
        //       color: const Color(0xFFFBFBFB),
        //       fontSize: 16.0,
        //       fontWeight: FontWeight.w700),
        //   unselectedLabelStyle: const TextStyle(
        //     color: const Color(0xFFE9E9E9),
        //     fontSize: 16.0,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF2E2E2E),
            unselectedItemColor: Color(0xFFFFFFFF),
            selectedItemColor: Color(0xFFBA2916)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xFF3B3B3B);
                  }
                  return const Color(0xFFBA2916);
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
                      color: Color(0xFF575757),
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
        //     foregroundColor: const Color(0xFF101010),
        //     side: const BorderSide(width: 0.0, style: BorderStyle.none),
        //     backgroundColor: const Color(0xFF202020),
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0)),
        //     minimumSize: const Size(0.0, 35.0),
        //   ),
        // ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFFBFBFB),
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFBA2916),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0xCCE45441),
          cursorColor: Color(0xCCE45441),
          selectionHandleColor: Color(0xCCBA2916),
        ),
      );
}
