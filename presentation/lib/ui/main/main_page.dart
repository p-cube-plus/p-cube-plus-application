import 'package:flutter/material.dart';
import 'package:presentation/ui/alarm/alarm_page.dart';
import 'package:presentation/ui/home/home_page.dart';
import 'package:presentation/ui/project/project_page.dart';
import 'package:presentation/ui/user/user_page.dart';

import 'main_navigation_bar_factory.dart';

class MainPage extends StatefulWidget {
  final MainNavigationType initializeType;
  const MainPage({
    super.key,
    required this.initializeType,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initializeType.navigationIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) => setState(() => _currentIndex = index),
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ProjectPage(),
          AlarmPage(),
          HomePage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedFontSize: 8,
        unselectedFontSize: 8,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        items: [
          MainNavigationBarFactory().create(MainNavigationType.project),
          MainNavigationBarFactory().create(MainNavigationType.alarm),
          MainNavigationBarFactory().create(MainNavigationType.home),
          MainNavigationBarFactory().create(MainNavigationType.user),
        ],
        onTap: (int tappedIndex) {
          _pageController.jumpToPage(tappedIndex);
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
