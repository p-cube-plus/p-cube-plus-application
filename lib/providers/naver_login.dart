import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_cube_plus_application/screens/mainpage/page_controller.dart';

class NaverLoginProvider with ChangeNotifier {
  late String nName, nGender, nBirth;

  Future<void> naverLogin(BuildContext context) async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();

    switch (res.status) {
      case NaverLoginStatus.loggedIn:
        Fluttertoast.showToast(
            msg: "${res.account.name}님! PCube+ 가입을 환영해요 :)",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageControll()),
        );

        // data 처리
        // nName = res.account.name;
        // nGender = res.account.birthyear;
        // nBirth = res.account.birthday;

        // debugPrint("test " + nName);
        // debugPrint("test " + nGender);
        // debugPrint("test " + nBirth);

        // retrofit으로 판큐 회원인지 검증해야됨
        // 아니면 탈퇴처리
        // UI에 뿌려주는 거

        break;
      case NaverLoginStatus.cancelledByUser:
        // 유저에 의해 cancel
        break;
      case NaverLoginStatus.error:
        // error
        break;
    }

    //notifyListeners();
  }

  void naverLogout(int index) {
    FlutterNaverLogin.logOut();

    nName = "이름 정보가 없습니다.";
    nGender = "성별 정보가 없습니다.";
    nBirth = "생일 정보가 없습니다.";
  }
}
