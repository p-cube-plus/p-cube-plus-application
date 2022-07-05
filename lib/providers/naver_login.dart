import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLoginProvider with ChangeNotifier {
  late String nName, nGender, nBirth;
  // final Uri loginApiUrl = Uri.parse('http://p-cube-plus.com/auth/naver/login');

  Future<void> naverLogin() async {
    //if (!await launchUrl(loginApiUrl)) throw 'Could not launch $loginApiUrl';

    NaverLoginResult res = await FlutterNaverLogin.logIn();

    switch (res.status) {
      case NaverLoginStatus.loggedIn:
        // data 처리
        nName = res.account.name;
        nGender = res.account.birthyear;
        nBirth = res.account.birthday;

        debugPrint("test " + nName);
        debugPrint("test " + nGender);
        debugPrint("test " + nBirth);

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

    // data 처리
    //nName = res.account.nickname;
    //nGender = res.account.gender;
    //nBirth = res.account.birthday;

    //notifyListeners();
  }

  void naverLogout(int index) {
    FlutterNaverLogin.logOut();

    nName = "이름 정보가 없습니다.";
    nGender = "성별 정보가 없습니다.";
    nBirth = "생일 정보가 없습니다.";
  }
}
