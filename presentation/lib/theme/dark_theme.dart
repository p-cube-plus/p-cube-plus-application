import 'package:flutter/material.dart';
import 'package:presentation/constants/app_color.dart' as color;

class GetDarkTheme {
  ThemeData call() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: "SpoqaHanSansNeo",
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF242424),
        ),
        tabBarTheme: TabBarTheme(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return color.darkGray20.withOpacity(0.5); // 클릭 시 번지는 색상
            }
            return null; // 기본 색상 유지
          }),
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
          selectedItemColor: color.darkPrimary80,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xFF3B3B3B);
                  }
                  return color.darkPrimary80;
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
              overlayColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return const Color(0xFFFFFFFF).withOpacity(0.1);
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return const Color(0xFFFFFFFF).withOpacity(0.05);
                  }
                  return Colors.transparent; // 기본 Ink 색상
                },
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
