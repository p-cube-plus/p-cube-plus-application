import 'package:flutter/material.dart';

// NewPageTile: 클릭 시 새 페이지로 넘어가는 설정
// SwitchTile: 스위치 기능의 설정
// alertTile: 클릭 시 alert창이 나오는 설정

// versionTile: 현재 앱버전을 알기 위한 특수한 설정
// mainTitleTile: AppBar 역할의 설정 텍스트
// subTextTile: 설정 구분을 위한 텍스트

// botttomsheetTile: bottomsheet를 띄우는 설정

abstract class TSettingTile extends StatelessWidget {
  static const double vertical = 10.0;
  static const double horizontal = 0.0;
  final defaultFontSize = 12.0;
  final verticalPadding = EdgeInsets.symmetric(vertical: vertical);
  final allPadding = EdgeInsets.symmetric(horizontal: 0.0, vertical: vertical);
  final background = Colors.white70;
  final title;

  TextStyle getTextStyle(BuildContext context, {bool isTitle = false}) =>
      isTitle
          ? Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              )
          : Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              );

  TSettingTile({required String this.title});
}
