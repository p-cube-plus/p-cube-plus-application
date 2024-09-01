import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/projects/projects_page.dart';
import 'package:p_cube_plus_application/screens/user_informations/user_information_page.dart';
import '../../../common/utils/contants.dart' as Constants;

import '../../../screens/fee/fee_page.dart';
import '../../../screens/home/home_page.dart';
import '../../../screens/notice/notice_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 2;
  final _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) => setState(() => _idx = index),
        children: [
          ProjectsPage(),
          FeePage(),
          HomePage(),
          NoticePage(),
          UserInformationPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //showSelectedLabels: false,
        //showUnselectedLabels: false,
        iconSize: 20,
        selectedFontSize: 8,
        unselectedFontSize: 8,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        items: [
          _getBar("프로젝트", Constants.Constants.projects,
              Constants.Constants.selected_projects),
          _getBar(
              "회비", Constants.Constants.fee, Constants.Constants.selected_fee),
          _getBar(
              "홈", Constants.Constants.home, Constants.Constants.selected_home),
          _getBar("알림", Constants.Constants.bell,
              Constants.Constants.selected_bell),
          _getBar("내 정보", Constants.Constants.user,
              Constants.Constants.selected_user),
        ],
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: _idx,
      ),
    );
  }

  _getBar(String label, String icon, String selectedIcon) {
    final theme = Theme.of(context);
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Constants.GetIcon(
          icon,
          color: theme.bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
      activeIcon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Constants.GetIcon(
          selectedIcon,
          color: theme.bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: label,
    );
  }
}
