import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/oauth_token.dart';
import '../services/oauth_api.dart';
import '../screens/main_page.dart';

class NaverLoginProvider with ChangeNotifier {
  late String nName, nGender, nBirth;

  Future<void> naverLogin(BuildContext context) async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();

    switch (res.status) {
      case NaverLoginStatus.loggedIn:
        NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;

        Map<String, String>? headers = {"Content-Type": "application/json"};
        Map<String, String>? queryParams = {
          "refresh_token": token.refreshToken,
          "identifier": res.account.id,
          "name": res.account.name,
          "phone_number": res.account.mobile,
        };

        OAuthToken? oAuthToken =
            await OAuthApi().get(headers: headers, queryParams: queryParams);

        if (oAuthToken?.accessToken != null) {
          Fluttertoast.showToast(
              msg: "${res.account.name}님! 로그인에 성공했어요 :)",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);

          debugPrint("Access Token: " + oAuthToken!.accessToken.toString());
          debugPrint("Refresh Token: " + oAuthToken.accessToken.toString());
          final fcmToken = await FirebaseMessaging.instance.getToken();
          debugPrint('FCM Token: ' + fcmToken.toString());
          // Token 저장
          TokenManager().setAccessToken(oAuthToken.accessToken.toString());
          TokenManager().setRefreshToken(oAuthToken.refreshToken.toString());

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            //System.isLogin = true;
            return MainPage();
          }));
        } else {
          Fluttertoast.showToast(
              msg: "${res.account.name}님! 로그인에 실패했어요 :(",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
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

  void naverLogout() {
    FlutterNaverLogin.logOut();
  }
}
