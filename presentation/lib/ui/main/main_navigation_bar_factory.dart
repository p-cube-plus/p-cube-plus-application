import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

enum MainNavigationType {
  project(0),
  fee(-2),
  home(2),
  alarm(1),
  user(3),
  ;

  const MainNavigationType(this.navigationIndex);
  final int navigationIndex;
}

class MainNavigationBarFactory {


  String _getLabel(MainNavigationType type) => switch (type) {
        MainNavigationType.project => "프로젝트",
        MainNavigationType.fee => "회비",
        MainNavigationType.home => "홈",
        MainNavigationType.alarm => "알림",
        MainNavigationType.user => "내 정보",
      };

  String _getSelectedIconPath(MainNavigationType type) => switch (type) {
        MainNavigationType.project => asset.projectIconSelected,
        MainNavigationType.fee => asset.feeIconSelected,
        MainNavigationType.home => asset.homeIconSelected,
        MainNavigationType.alarm => asset.alarmIconSelected,
        MainNavigationType.user => asset.userIconSelected,
      };

  String _getUnselectedIconPath(MainNavigationType type) => switch (type) {
        MainNavigationType.project => asset.projectIconUnselected,
        MainNavigationType.fee => asset.feeIconUnselected,
        MainNavigationType.home => asset.homeIconUnselected,
        MainNavigationType.alarm => asset.alarmIconUnselected,
        MainNavigationType.user => asset.userIconUnselected,
      };
}
