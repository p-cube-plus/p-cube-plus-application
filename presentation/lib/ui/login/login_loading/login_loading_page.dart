import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/login_failed/login_failed_page.dart';
import 'package:presentation/ui/login/login_home/login_home_page.dart';
import 'package:presentation/ui/login/login_loading/login_loading_page_viewmodel.dart';
import 'package:presentation/ui/login/login_loading/login_loading_state.dart';
import 'package:presentation/ui/main/main_navigation_bar_factory.dart';
import 'package:presentation/ui/main/main_page.dart';
import 'package:presentation/widgets/logo_splash_widget.dart';
import 'package:provider/provider.dart';

class LoginLoadingPage extends StatelessWidget {
  final String phoneNumber;
  final String name;

  const LoginLoadingPage(
      {super.key, required this.phoneNumber, required this.name});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginLoadingPageViewModel(phoneNumber, name),
      child: const _LoginLoadingPage(),
    );
  }
}

class _LoginLoadingPage extends StatefulWidget {
  const _LoginLoadingPage();

  @override
  State<_LoginLoadingPage> createState() => LoginLoadingPageState();
}

class LoginLoadingPageState extends State<_LoginLoadingPage>
    with ViewModel<LoginLoadingPageViewModel> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _setStateListener();
    });
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
            LogoSplashWidget(size: 153),
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
    read(context).eventStream.listen((event) {
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
      MaterialPageRoute(
        builder: (context) => const MainPage(
          initializeType: MainNavigationType.home,
        ),
      ),
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
