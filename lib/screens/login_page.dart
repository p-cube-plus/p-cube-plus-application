import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/main.dart';
import 'package:p_cube_plus_application/screens/main_page.dart';
import 'package:provider/provider.dart';
import '../utilities/contants.dart' as Constants;

// 임시
import '../providers/naver_login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Constants.Icons.GetIcon(Constants.Icons.main_logo),
                height: 168,
                width: 138,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: Column(
                children: [
                  _ShowButton(),
                  SizedBox(height: 8.0),
                  _ShowTextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.5, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 24),
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Constants.Icons.GetIcon(Constants.Icons.naver)),
                ),
                Text("네이버 아이디로 로그인",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ],
            ),
          ),
          style: theme.elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF1EC402)),
          ),
          onPressed: () =>
              context.read<NaverLoginProvider>().naverLogin(context)),
    );
  }
}

class _ShowTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 98),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          child: Text('동아리 가입 신청서 작성하기',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.w500)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              System.isLogin = true;
              return MainPage();
            }),
          ),
        ),
      ),
    );
  }
}
