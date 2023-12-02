import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/guest/guest_main_page.dart';
import 'package:p_cube_plus_application/screens/guest/guest_notion_webview_page.dart';
import 'package:p_cube_plus_application/screens/login/authentication_page.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import '../../utilities/contants.dart' as Constants;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultPage(
      appbar: null,
      backgroundColor: theme.colorScheme.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Column(
            children: [
              Constants.Icons.GetIcon(Constants.Icons.main_text_logo),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontFamily: "Spectral SC",
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: "판도라큐브에 ",
                      style: TextStyle(
                        color: theme.textTheme.headlineSmall!.color,
                      ),
                    ),
                    TextSpan(
                      text: "플러스",
                      style: TextStyle(
                        color: MyThemes.primary80,
                      ),
                    ),
                    TextSpan(
                      text: "가 되다",
                      style: TextStyle(
                        color: theme.textTheme.headlineSmall!.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
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
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AuthenticationPage(),
                    //DefaultAlert(
                    //  title: "로그인에 실패했어요.",
                    //  description: "다시 시도해주세요.",
                    //  messageType: MessageType.OK,
                    //),
                  ),
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
          ),
        ],
      ),
    );
  }
}
