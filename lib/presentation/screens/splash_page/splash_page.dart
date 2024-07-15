import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:p_cube_plus_application/presentation/screens/login_page/login_page.dart';
import 'package:p_cube_plus_application/presentation/viewmodels/splash_page_viewmodel.dart';
import 'package:p_cube_plus_application/presentation/screens/main_page/main_page.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final viewModel = SplashPageViewModel();
  late final Future<void> _checkIsNeedLoginJob;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _checkIsNeedLoginJob = viewModel.checkIsNeedLogin();
  }

  @override
  void dispose() {
    _controller.dispose();
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
              'assets/lottie/pcube+_logo_splash.json',
              width: 160,
              height: 160,
              repeat: false,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    navigate();
                  }
                });
                _controller.forward();
              },
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/icons/pcube_text_logo.svg'),
          ],
        ),
      ),
    );
  }

  Future<void> navigate() async {
    await _checkIsNeedLoginJob;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            (viewModel.isNeedLogin) ? LoginPage() : MainPage(),
      ),
      (route) => false,
    );
  }
}
