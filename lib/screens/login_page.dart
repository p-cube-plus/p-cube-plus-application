import 'package:flutter/material.dart';

// 임시
import 'mainpage/main_page_controller.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: const _MainLogin(),
        ),
      ),
    );
  }
}

class _MainLogin extends StatelessWidget {
  const _MainLogin();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const _ShowLogo(),
          const _ShowButton(),
          const _ShowTextButton(),
        ],
      ),
    );
  }
}

class _ShowLogo extends StatelessWidget {
  const _ShowLogo();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('../../assets/images/symbol.png')),
      height: 500,
      width: 500,
      margin: EdgeInsets.only(bottom: 60),
    );
  }
}

class _ShowButton extends StatelessWidget {
  const _ShowButton();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ButtonBar(
      alignment: MainAxisAlignment.center,
      //buttonMinWidth: MediaQuery.of(context).size.width * 0.35,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ElevatedButton(
            child: Row(
              children: [
                const Text(
                  "네이버 아이디로 로그인",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              primary: Color(0xff2DB400), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              _goNaverPage(context);
            },
          ),
        ),
      ],
    ));
  }

  void _goNaverPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }
}

class _ShowTextButton extends StatelessWidget {
  const _ShowTextButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          //primary: Color.fromARGB(153, 75, 75, 75),
          textStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        child: const Text(
          '동아리 가입 신청서 작성하기',
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () {
          _goApplicationPage(context);
        },
      ),
      margin: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width * 0.5,
    );
  }

  void _goApplicationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }
}
