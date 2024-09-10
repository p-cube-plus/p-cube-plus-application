import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/ui/splash/splash_state.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/splash/splash_page_viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as path;
import 'package:presentation/widgets/default_alert.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin, ViewModel<SplashPageViewModel> {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          read(context).triggerEvent(SplashEvent.animationComplete);
        }
      });

    Future.microtask(() {
      _setStateListener();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              path.logoSplash,
              controller: _animationController,
              width: 160,
              height: 160,
              onLoaded: (composition) => _animationController
                ..duration = composition.duration
                ..forward(),
            ),
            const SizedBox(height: 16),
            SvgPicture.asset(path.textLogo),
          ],
        ),
      ),
    );
  }

  void _setStateListener() {
    read(context).uiSideEffectStream.listen((event) {
      switch (event) {
        case SplashState.loginSuccess:
          _navigateToHomePage();
        case SplashState.needLogin:
          _navigateToLoginPage();
        case SplashState.failedInit:
          _exitApp();
      }
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginHomePage(),
      ),
      (route) => false,
    );
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginHomePage(),
      ),
      (route) => false,
    );
  }

  void _exitApp() {
    final errorMessage = read(context).initErrorMessage;
    DialogBuilder().build(
      context,
      DefaultAlert(
        title: "앱 실행에 문제가 발생했습니다.",
        messageType: MessageType.ok,
        description: errorMessage,
        onTap: () => exit(0),
      ),
    );
  }
}
