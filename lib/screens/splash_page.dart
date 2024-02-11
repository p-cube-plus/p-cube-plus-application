import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:p_cube_plus_application/models/auth_token.dart';
import 'package:p_cube_plus_application/providers/token_provider.dart';
import 'package:p_cube_plus_application/screens/login/login_page.dart';
import 'package:p_cube_plus_application/screens/main_page.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  Timer? _timer;
  AuthToken? authToken;
  bool apiCompleted = false;
  bool timerCompleted = false;

  @override
  void initState() {
    super.initState();
    refreshToken();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        timerCompleted = true;
      });
      navigate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void refreshToken() async {
    authToken = await context.read<TokenProvider>().refreshToken();
    if (authToken != null) {
      TokenManager().setAccessToken(authToken!.accessToken.toString());
      TokenManager().setRefreshToken(authToken!.refreshToken.toString());
    }
    apiCompleted = true;
    navigate();
  }

  void navigate() {
    if (timerCompleted && apiCompleted && mounted)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (authToken != null && authToken?.accessToken != null)
                  ? MainPage()
                  : LoginPage(),
        ),
        (route) => false,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/pcube+_logo_splash.json',
              width: 160,
              height: 160,
              repeat: true,
              // animate: false,
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/icons/pcube_text_logo.svg'),
          ],
        ),
      ),
    );
  }
}
