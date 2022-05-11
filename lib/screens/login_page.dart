import 'package:flutter/material.dart';

// 임시
import 'current_notice_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: _MainLogin(context),
        ),
      ),
    );
  }

  Widget _MainLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _ShowLogo(context),
        _ShowButton(context),
        _ShowTextButton(context),
      ],
    );
  }

  Container _ShowLogo(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('../../assets/images/symbol.png')),
      height: MediaQuery.of(context).size.height * 0.60,
      width: MediaQuery.of(context).size.width * 0.60,
    );
  }

  ButtonBar _ShowButton(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonHeight: MediaQuery.of(context).size.height * 0.09,
      buttonMinWidth: MediaQuery.of(context).size.width * 0.50,
      children: [
        RaisedButton(
          child: Text(
            "네이버 아이디로 로그인",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          color: Colors.green,
          onPressed: () {
            _GoNaverPage(context);
          },
        ),
      ],
    );
  }

  Container _ShowTextButton(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 14),
        ),
        child: const Text('동아리 가입 신청서 작성'),
        onPressed: () {
          _GoApplicationPage(context);
        },
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.35,
    );
  }

  void _GoApplicationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurNoticePage()),
    );
  }

  void _GoNaverPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurNoticePage()),
    );
  }
}
