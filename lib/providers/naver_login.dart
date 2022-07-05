import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLoginProvider with ChangeNotifier {
  late String nName, nGender, nBirth;

  void naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    // data 처리
    nName = res.account.nickname;
    nGender = res.account.gender;
    nBirth = res.account.birthday;

    //notifyListeners();
  }

  void naverLogout(int index) {
    FlutterNaverLogin.logOut();

    nName = "이름 정보가 없습니다.";
    nGender = "성별 정보가 없습니다.";
    nBirth = "생일 정보가 없습니다.";
  }
}
