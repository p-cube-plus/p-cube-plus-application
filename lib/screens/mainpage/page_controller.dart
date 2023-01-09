import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/rent_provider.dart';
import 'package:p_cube_plus_application/screens/user_informations/user_information_page.dart';
import 'package:provider/provider.dart';
import '../../utilities/contants.dart' as Constants;

import '../project/project_page.dart';
import '../rent/rent_page.dart';
import 'home_page.dart';
import 'notice_page.dart';

class PageControll extends StatefulWidget {
  @override
  State<PageControll> createState() => _PageControllState();
}

class _PageControllState extends State<PageControll> {
  int _idx = 0;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            _idx = index;
          });
        },
        children: [
          HomePage(),
          ProjectListPage(),
          NoticePage(),
          UserInformationPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        items: [
          _getBarItem(Constants.Icons.home, Constants.Icons.selected_home, "홈"),
          _getBarItem(Constants.Icons.project, Constants.Icons.selected_project,
              "프로젝트"),
          _getBarItem(
              Constants.Icons.bell, Constants.Icons.selected_bell, "알림"),
          _getBarItem(
              Constants.Icons.user, Constants.Icons.selected_user, "유저정보")
        ],
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        currentIndex: _idx,
      ),
    );
  }

  BottomNavigationBarItem _getBarItem(
      String iconName, String iconSelectedName, String labelName) {
    return BottomNavigationBarItem(
      icon: Constants.Icons.GetIcon(
        iconName,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
      activeIcon: Constants.Icons.GetIcon(
        iconSelectedName,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      ),
      label: labelName,
    );
  }
}
