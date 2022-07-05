import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/user_informations/user_information_page.dart';

import 'home_page.dart';
import 'notice_page.dart';

class PageControll extends StatefulWidget {
  @override
  State<PageControll> createState() => _PageControllState();
}

class _PageControllState extends State<PageControll> {
  int _idx = 0;
  final pageController = PageController();

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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '알림'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '설정'),
        ],
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        currentIndex: _idx,
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 252, 73, 73)),
      ),
    );
  }
}
