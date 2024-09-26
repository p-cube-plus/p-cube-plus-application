import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/login_home/login_home_logo_widget.dart';
import 'package:presentation/ui/login/login_home_bottomsheet/login_home_bottomsheet.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_page.dart';

class LoginHomePage extends StatelessWidget {
  const LoginHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultPage(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const LoginHomeLogoWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () => _showBottomSheet(context),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        "PCube+ 시작하기",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _navigateToLoginToGuest(context),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Guest 모드로 로그인",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral80,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _navigateToPCubeIntroPage(context),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "판도라큐브 소개 바로가기",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40)
            ],
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    BottomSheetBuilder().build(
      context,
      const LoginHomeBottomsheet(),
    );
  }

  void _navigateToLoginToGuest(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }

  void _navigateToPCubeIntroPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }
}
