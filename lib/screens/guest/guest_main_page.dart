import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/guest/guest_home_page.dart';
import 'package:p_cube_plus_application/screens/guest/guest_information_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_alert.dart';
import '../../utilities/contants.dart' as Constants;

class GuestMainPage extends StatefulWidget {
  @override
  State<GuestMainPage> createState() => _GuestMainPageState();
}

class _GuestMainPageState extends State<GuestMainPage> {
  int _idx = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => DefaultAlert(
          title: "어서오세요!",
          description:
              "PCube+는 세종대학교 게임제작 동아리\n판도라큐브를 지원하는 편의 서비스입니다.\n게스트 모드로 PCube+를 먼저 둘러보세요.",
          messageType: MessageType.OK,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) => setState(() => _idx = index),
        children: [
          GuestHomePage(),
          GuestInformationPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedFontSize: 8,
        unselectedFontSize: 8,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        items: [
          _getBar("홈", Constants.Icons.home, Constants.Icons.selected_home),
          _getBar("내 정보", Constants.Icons.user, Constants.Icons.selected_user),
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
        child: Constants.Icons.GetIcon(
          icon,
          color: theme.bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
      activeIcon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Icons.GetIcon(
          selectedIcon,
          color: theme.bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: label,
    );
  }
}
