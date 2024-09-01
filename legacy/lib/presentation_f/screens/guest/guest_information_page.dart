import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/guest/guest_notion_webview_page.dart';
import 'package:p_cube_plus_application/screens/guest/guest_setting_page.dart';
import 'package:p_cube_plus_application/view/authentication_page/authentication_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_profile.dart';
import 'package:p_cube_plus_application/widgets/common/list_divider.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

class GuestInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "내 정보",
      action: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuestSettingPage(),
            ),
          );
        },
        child: Icon(
          Icons.settings,
          color: Theme.of(context).textTheme.headline2!.color,
        ),
      ),
      content: GuestInformationContent(),
    );
  }
}

class GuestInformationContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  const DefaultProfile(size: 72),
                  const SizedBox(width: 16),
                  Text("Guest",
                      style: theme.textTheme.displayLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
              ListDivider(vertial: 20.0),
            ],
          ),
          WellcomeGuestContent(),
          SizedBox(),
        ],
      ),
    );
  }
}

class WellcomeGuestContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Guest 모드로 접속했어요!",
              style: theme.textTheme.headlineSmall!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(height: 6),
          Text(
            "PCube+의 서비스를 이용하고 싶다면",
            style: theme.textTheme.displaySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "먼저 판도라큐브 동아리의 회원이어야 해요.",
            style: theme.textTheme.displaySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
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
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GuestWebViewPage()),
            ),
            child: Text(
              "판도라큐브 소개 바로가기",
              style: TextStyle(color: theme.textTheme.displayMedium!.color),
            ),
          ),
        ],
      ),
    );
  }
}
