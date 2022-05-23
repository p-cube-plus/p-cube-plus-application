import 'package:flutter/material.dart';
import '../widgets/notice_list_widget.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 0;
  final pageController = PageController();

  List titleOptions = [
    const Text('홈'),
    const Text('알림'),
    const Text('설정'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleOptions[_idx],
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        shadowColor: Color.fromARGB(33, 255, 255, 255),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Color.fromARGB(255, 0, 0, 0),
          tooltip: '뒤로 가기',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            _idx = index;
          });
        },
        children: [
          Text('준비중'),
          NoticeListWidget(),
          Text('준비중'),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        unselectedIconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
