import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/guest/guest_main_page.dart';
import 'package:p_cube_plus_application/screens/guest/guest_notion_webview_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_bottomsheet.dart';

import '../../../../../presentation/lib/view/login_page/notice_member_only_bottomSheet.dart';

class LoginButtonWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "PCube+ 시작하기",
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            onPressed: () {
              BottomSheetBuilder().build(
                context,
                "잠깐,\n판도라큐브 회원이신가요?",
                contents: [NoticeMemberOnlyBottomSheet()],
                bottomPadding: 48,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuestMainPage()),
          ),
          child: Text(
            "Guest 모드로 로그인",
            style: TextStyle(color: theme.textTheme.headlineSmall!.color),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuestWebViewPage(),
            ),
          ),
          child: Text(
            "판도라큐브 소개 바로가기",
            style: TextStyle(color: theme.textTheme.displaySmall!.color),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
