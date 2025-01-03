import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';

class UserLogoutCompletePage extends StatelessWidget {
  const UserLogoutCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "로그아웃 되었습니다.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: theme.neutral100,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "다시 로그인하려면\n로그인 화면으로 돌아가기를 눌러주세요.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 48),
            child: ElevatedButton(
              onPressed: () => _navigateToLoginPage(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "로그인 화면으로 돌아가기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => LoginHomePage(),
      ),
      (route) => false,
    );
  }
}
