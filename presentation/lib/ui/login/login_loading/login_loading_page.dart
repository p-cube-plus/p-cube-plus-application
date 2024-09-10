import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/login_failed/login_failed_page.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/login/login_loading/login_loading_page_viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as path;
import 'package:presentation/ui/login/login_loading/login_loading_state.dart';

class LoginLoadingPage extends StatefulWidget {
  const LoginLoadingPage({super.key});

  @override
  State<LoginLoadingPage> createState() => LoginLoadingPageState();
}

class LoginLoadingPageState extends State<LoginLoadingPage>
    with SingleTickerProviderStateMixin, ViewModel<LoginLoadingPageViewModel> {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
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
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(path.logoSplash,
                controller: _animationController,
                width: 153,
                height: 153,
                repeat: true,
                onLoaded: (composition) => _animationController
                  ..duration = composition.duration
                  ..forward()),
            const SizedBox(height: 40),
            Text(
              "회원 정보를 조회하고 있어요.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "잠시만 기다려주세요!",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.neutral60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setStateListener() {
    read(context).uiSideEffectStream.listen((event) {
      switch (event) {
        case LoginLoadingState.successLogin:
          _navigateToHomePage();
        case LoginLoadingState.failedLogin:
          _navigateToFailedLoginPage();
        case LoginLoadingState.errorLogin:
          _showErrorToast();
          _navigateToLoginHomePage();
      }
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Container()),
      (route) => false,
    );
  }

  void _navigateToFailedLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginFailedPage()),
      (route) => false,
    );
  }

  void _showErrorToast() {
    Fluttertoast.showToast(msg: read(context).errorMessage);
  }

  void _navigateToLoginHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginHomePage()),
      (route) => route.isFirst,
    );
  }
}
