import 'package:flutter/material.dart';

import 'current_notice_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 0;

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
      ),
      body: Center(
        child: const Text("sample"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: '알림'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '설정'),
        ],
        onTap: (int index) {
          setState(() {
            _idx = index;
          });

          switch (index) {
            case 1:
              _goNaverPage(context);
          }
        },
        currentIndex: _idx,
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 252, 73, 73)),
        unselectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  void _goNaverPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurNoticePage()),
    );
  }
}
