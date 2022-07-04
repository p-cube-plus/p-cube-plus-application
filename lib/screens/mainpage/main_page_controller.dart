import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'notice_list_screen.dart';
import 'setting_screen.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          HomeWidget(),
          NoticeListWidget(),
          SettingListWidget(),
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
