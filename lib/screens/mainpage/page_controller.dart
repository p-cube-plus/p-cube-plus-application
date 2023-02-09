import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/projects/projects_page.dart';
import 'package:p_cube_plus_application/screens/user_informations/user_information_page.dart';
import '../../utilities/contants.dart' as Constants;

import '../fee/fee_page.dart';
import 'home_page.dart';
import '../notice/notice_page.dart';

class PageControll extends StatefulWidget {
  @override
  State<PageControll> createState() => _PageControllState();
}

class _PageControllState extends State<PageControll> {
  int _idx = 2;
  final pageController = PageController(initialPage: 2);

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
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        items: [
          _getItem("프로젝트", Constants.Icons.projects,
              Constants.Icons.selected_projects),
          _getItem("회비", Constants.Icons.fee, Constants.Icons.selected_fee),
          _getItem("홈", Constants.Icons.home, Constants.Icons.selected_home),
          _getItem("알림", Constants.Icons.bell, Constants.Icons.selected_bell),
          _getItem("마이", Constants.Icons.user, Constants.Icons.selected_user),
        ],
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        currentIndex: _idx,
      ),
    );
  }

  _getItem(String lebel, String icon, String selectedIcon) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Icons.GetIcon(
          icon,
          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
      activeIcon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Icons.GetIcon(
          selectedIcon,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: lebel,
    );
  }
}
