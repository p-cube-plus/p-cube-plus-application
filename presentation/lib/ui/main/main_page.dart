import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_page.dart';
import 'package:presentation/ui/notification/notification_page.dart';
import 'package:presentation/ui/home/home_page.dart';
import 'package:presentation/ui/project/project_page.dart';
import 'package:presentation/ui/user/user_page.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
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
          FeePage(),
          HomePage(),
          NotificationPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.background,
          iconSize: 20,
          selectedFontSize: 8,
          selectedItemColor: theme.primary80,
          selectedLabelStyle: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: theme.primary80,
          ),
          unselectedFontSize: 8,
          unselectedItemColor: theme.neutral40,
          unselectedLabelStyle: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: theme.neutral40,
          ),
          items: [
            getDefaultNavigationBarItem(
              "프로젝트",
              asset.projectIconUnselected,
              asset.projectIconSelected,
            ),
            getDefaultNavigationBarItem(
              "회비",
              asset.feeIconUnselected,
              asset.feeIconSelected,
            ),
            getDefaultNavigationBarItem(
              "홈",
              asset.homeIconUnselected,
              asset.homeIconSelected,
            ),
            getDefaultNavigationBarItem(
              "알림",
              asset.alarmIconUnselected,
              asset.alarmIconSelected,
            ),
            getDefaultNavigationBarItem(
              "내 정보",
              asset.userIconUnselected,
              asset.userIconSelected,
            ),
          ],
          onTap: (int tappedIndex) {
            _pageController.jumpToPage(tappedIndex);
          },
          currentIndex: _currentIndex,
        ),
      ),
    );
  }

  BottomNavigationBarItem getDefaultNavigationBarItem(
    String label,
    String unselectedSvgAssetName,
    String selectedSvgAssetName,
  ) {
    final theme = Theme.of(context);
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          unselectedSvgAssetName,
          colorFilter: ColorFilter.mode(theme.neutral40, BlendMode.srcIn),
        ),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          selectedSvgAssetName,
          colorFilter: ColorFilter.mode(theme.primary80, BlendMode.srcIn),
        ),
      ),
      label: label,
    );
  }
}
