import 'package:flutter/material.dart';

// NewPageTile: 클릭 시 새 페이지로 넘어가는 설정
// SwitchTile: 스위치 기능의 설정

abstract class SettingTile extends StatelessWidget {
  final height = 50.0;
  final blank = 20.0;
  final background = Colors.white70;
  final title;

  SettingTile({required String this.title});
}
