import 'package:flutter/material.dart';

// 임시
import 'notice_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _MainLogin(context),
      ),
    );
  }

  Widget _MainLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Image(image: AssetImage('../../assets/images/symbol.png')),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          buttonHeight: 70,
          buttonMinWidth: 250,
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
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 14),
          ),
          child: const Text('동아리 가입 신청서 작성'),
          onPressed: () {
            _GoApplicationPage(context);
          },
        )
      ],
    );
  }

  void _GoApplicationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoticePage()),
    );
  }

  void _GoNaverPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoticePage()),
    );
  }
}
