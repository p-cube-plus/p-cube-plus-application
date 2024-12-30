import 'package:flutter/material.dart';
import 'package:presentation/constants/app_color.dart' as color;

class GetLightTheme {
  ThemeData call() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: "SpoqaHanSansNeo",
        colorScheme: const ColorScheme.light(
          surface: Color(0xFFFBFBFB),
        ),
        tabBarTheme: TabBarTheme(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return color.lightGray20.withOpacity(0.5); // 클릭 시 번지는 색상
            }
            return null; // 기본 색상 유지
          }),
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
          selectedItemColor: color.lightPrimary80,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xFFE9E9E9);
                  }
                  return color.lightPrimary80;
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
                    return const Color(0xFFFFFFFF).withOpacity(0.2);
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return const Color(0xFFFFFFFF).withOpacity(0.1);
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
          color: color.lightPrimary80,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: color.lightPrimary80,
          cursorColor: color.lightPrimary60,
          selectionHandleColor: color.lightPrimary60,
        ),
      );
}
