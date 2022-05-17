import 'package:flutter/material.dart';

// 임시
import 'main_page.dart';

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
      height: MediaQuery.of(context).size.height * 0.60,
      width: MediaQuery.of(context).size.width * 0.60,
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
      buttonHeight: MediaQuery.of(context).size.height * 0.09,
      buttonMinWidth: MediaQuery.of(context).size.width * 0.50,
      children: [
        ElevatedButton(
          child: Text(
            "네이버 아이디로 로그인",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {
            _goNaverPage(context);
          },
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
          textStyle: const TextStyle(fontSize: 14),
        ),
        child: const Text('동아리 가입 신청서 작성'),
        onPressed: () {
          _goApplicationPage(context);
        },
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.35,
    );
  }

  void _goApplicationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }
}
