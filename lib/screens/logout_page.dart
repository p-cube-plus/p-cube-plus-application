import 'package:flutter/material.dart';
import 'login_page.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '로그아웃 되었습니다.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            Text(
              '다시 로그인 하시려면',
              style: TextStyle(color: Colors.white54),
            ),
            Text(
              '홈으로 돌아가기를 눌러주세요.',
              style: TextStyle(color: Colors.white54),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('홈으로 돌아가기'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ],
        ),
      ),
    );
  }
}
