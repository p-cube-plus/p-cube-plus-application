import 'package:flutter/material.dart';
import 'package:presentation/theme/text_theme_extension.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/widgets/default_page.dart';

class LoginFailedPage extends StatelessWidget {
  const LoginFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 84, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "일치하는 회원 정보가\n조회되지 않았어요.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: theme.neutral100,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "처음부터 다시 시도해주세요.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral60,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 56,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => _navigateToLoginHomePage(context),
                  child: const Text("처음으로 돌아가기"),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "판도라큐브 회원이 아니신가요?",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral40,
                ),
              ),
              const SizedBox(height: 6),
              TextButton(
                  onPressed: () => _navigateToPCubeIntroPage(context),
                  child: Text(
                    "판도라큐브 소개 바로가기",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral80,
                    ),
                  )),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToLoginHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginHomePage(),
        ),
        (route) => false);
  }

  void _navigateToPCubeIntroPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginHomePage(),
        ),
        (route) => false);
  }
}
