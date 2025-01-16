import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/main/main_navigation_bar_factory.dart';
import 'package:presentation/ui/main/main_page.dart';
import 'package:presentation/ui/splash/splash_event.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/splash/splash_page_viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as path;
import 'package:presentation/widgets/default_alert.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashPageViewModel(),
      child: const _SplashPage(),
    );
  }
}

class _SplashPage extends StatefulWidget {
  const _SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<_SplashPage>
    with SingleTickerProviderStateMixin, ViewModel<SplashPageViewModel> {
  late final AnimationController _animationController;
  bool _isLogoVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          read(context).changeStateBasedOnLogin();
        }
      });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLogoVisible = true;
      });
    });
    Future.microtask(() => _setStateListener());
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
      backgroundColor: theme.background,
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
            AnimatedOpacity(
              curve: Curves.easeInCirc,
              opacity: _isLogoVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(path.textLogo),
            ),
          ],
        ),
      ),
    );
  }

  void _setStateListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case SplashEventFailedInit():
          _exitApp(event.errorMessage);
        case SplashEventNavigateToMainPage():
          _navigateToMainPage();
        case SplashEventNavigateToLoginPage():
          _navigateToLoginPage();
      }
    });
  }

  void _navigateToMainPage() {
    Navigator.of(context).pushAndRemoveUntil(
      SplashRouteBuilder(
        page: const MainPage(initializeType: MainNavigationType.home),
      ),
      (route) => false,
    );
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      SplashRouteBuilder(page: const LoginHomePage()),
      (route) => false,
    );
  }

  void _exitApp(String errorMessage) {
    DialogBuilder().build(
      context,
      DefaultAlert(
        title: "앱 실행에 문제가 발생했습니다.",
        messageType: MessageType.ok,
        description: errorMessage,
        onTapOk: () => exit(0),
      ),
    );
  }
}

class SplashRouteBuilder extends PageRouteBuilder {
  final Widget page;
  SplashRouteBuilder({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );
}
