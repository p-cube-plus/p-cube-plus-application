import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/guest/guest_main_page.dart';
import 'package:p_cube_plus_application/screens/guest/guest_notion_webview_page.dart';
import 'package:p_cube_plus_application/screens/login/authentication_page.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/widgets/common/default_bottomsheet.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import '../../utilities/contants.dart' as Constants;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool isCheckIcon = false;
  @override
  void initState() {
    isCheckIcon = false;
    super.initState();
  }

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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (context) => StatefulBuilder(builder:
                          (BuildContext context, StateSetter bottomState) {
                        return DefaultBottomsheet(
                          title: "잠깐,\n판도라큐브 회원이신가요?",
                          bottomPadding: 48,
                          contents: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "판도라큐브 회원이 아닌 경우 가입이 불가능해요.\nGuest 모드로 시작해 주세요.",
                                style: TextStyle(
                                    color: theme.textTheme.displaySmall!.color),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 30,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Container(
                                          child: Constants.Icons.GetIcon(
                                            isCheckIcon
                                                ? Constants
                                                    .Icons.selected_check_circle
                                                : Constants.Icons.check_circle,
                                            color: isCheckIcon
                                                ? null
                                                : theme.bottomNavigationBarTheme
                                                    .unselectedItemColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "네, 판도라큐브 회원입니다.",
                                        style: TextStyle(
                                            color: theme.textTheme
                                                .headlineSmall!.color),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () => bottomState(() {
                                setState(() {
                                  isCheckIcon = !isCheckIcon;
                                });
                              }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "시작하기",
                                      style: isCheckIcon
                                          ? theme.textTheme.headlineMedium!
                                              .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            )
                                          : theme.textTheme.headlineMedium!
                                              .copyWith(
                                              fontSize: 16,
                                              color: const Color(0xFFABABAB),
                                              fontWeight: FontWeight.w700,
                                            ),
                                    ),
                                  ),
                                ),
                                onPressed: isCheckIcon
                                    ? () => showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AuthenticationPage(),
                                        )
                                    : null,
                                onLongPress: null,
                              ),
                            ),
                          ],
                        );
                      }),
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
          ),
        ],
      ),
    );
  }
}
