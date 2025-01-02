import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/guest/guest_home_page.dart';
import 'package:presentation/ui/guest/guest_user_page.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class GuestMainPage extends StatefulWidget {
  const GuestMainPage({
    super.key,
  });

  @override
  State<GuestMainPage> createState() => _GuestMainPageState();
}

class _GuestMainPageState extends State<GuestMainPage> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
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
          GuestHomePage(),
          GuestUserPage(),
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
              "홈",
              asset.homeIconUnselected,
              asset.homeIconSelected,
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