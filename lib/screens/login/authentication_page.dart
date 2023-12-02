import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/main_page.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/widgets/common/default_textField.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import '../../utilities/contants.dart' as Constants;

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isReadyPhoneNumber = false;
  bool isAuthenticatedPhoneNumber = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isReadyPhoneNumber
        ? isAuthenticatedPhoneNumber
            ? InputNamePage()
            : AuthenticationPhoneNumberPage(
                authenticationSuccess: () =>
                    setState(() => isAuthenticatedPhoneNumber = true))
        : InputPhoneNumberPage(
            clickAuthentication: () =>
                setState(() => isReadyPhoneNumber = true));
  }
}

class InputPhoneNumberPage extends StatelessWidget {
  InputPhoneNumberPage({required this.clickAuthentication});
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Function clickAuthentication;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        body: DefaultPage(
          appbar: DefaultAppBar(),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "전화번호를 입력해주세요.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      color: theme.textTheme.displayLarge!.color),
                ),
                SizedBox(height: 8),
                Text(
                  "회원 정보 조회 이외의 용도로 사용되지 않아요.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: theme.textTheme.displayMedium!.color),
                ),
                SizedBox(height: 70),
                RoundedBorder(
                  color: theme.scaffoldBackgroundColor,
                  child: DefaultTextField(
                    maxLength: 12,
                    minLine: 1,
                    maxLine: 1,
                    fontSize: 16.0,
                    contentPadding: 16,
                    hintText: "전화번호를 입력해주세요.",
                    textType: TextInputType.number,
                    inputController: _controller,
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => clickAuthentication(),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("인증 요청하기",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}

class AuthenticationPhoneNumberPage extends StatefulWidget {
  const AuthenticationPhoneNumberPage({required this.authenticationSuccess});
  final Function authenticationSuccess;
  @override
  State<AuthenticationPhoneNumberPage> createState() =>
      _AuthenticationPhoneNumberPageState();
}

class _AuthenticationPhoneNumberPageState
    extends State<AuthenticationPhoneNumberPage> {
  final TextEditingController _controller = TextEditingController();
  Duration timeoutCount = Duration(minutes: 3);
  String timeoutText = "";
  bool isInvalidInput = false;

  @override
  void initState() {
    super.initState();
    setState(() => timeoutText = getTimeoutText());

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (isInvalidInput) timer.cancel();

      timeoutCount -= const Duration(seconds: 1);
      setState(() => timeoutText = getTimeoutText());

      if (timeoutCount == const Duration(minutes: 0, seconds: 0)) {
        setState(() => timeoutText = "인증시간이 초과했습니다.");
        timer.cancel();
      }
    });
  }

  String getTimeoutText() =>
      '${timeoutCount.inMinutes}:${(timeoutCount.inSeconds % 60).toString().padLeft(2, '0')}';

  void invalidAuthentication() {
    isInvalidInput = true;
    setState(() => timeoutText = "잘못된 인증번호에요.");
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "인증번호가 발송되었어요.",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                  color: theme.textTheme.displayLarge!.color),
            ),
            SizedBox(height: 8),
            Text(
              "인증번호가 발송되지 않은 경우 재요청 버튼을 눌러주세요.",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  color: theme.textTheme.displayMedium!.color),
            ),
            SizedBox(height: 45),
            Row(children: [
              Constants.Icons.GetIcon(Constants.Icons.watch),
              SizedBox(width: 4),
              Text(
                timeoutText,
                style: TextStyle(
                  color: MyThemes.primary80,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ]),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RoundedBorder(
                    width: 150,
                    color: theme.scaffoldBackgroundColor,
                    child: DefaultTextField(
                      maxLength: 12,
                      minLine: 1,
                      maxLine: 1,
                      fontSize: 16.0,
                      contentPadding: 16,
                      hintText: "인증번호 입력",
                      textType: TextInputType.number,
                      inputController: _controller,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                      onPressed: () => widget.authenticationSuccess(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "재요청",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: theme.textTheme.headlineMedium!.color),
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputNamePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        body: DefaultPage(
          appbar: DefaultAppBar(),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "이름을 입력해주세요.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      color: theme.textTheme.displayLarge!.color),
                ),
                SizedBox(height: 8),
                Text(
                  "회원 정보 조회 이외의 용도로 사용되지 않아요.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: theme.textTheme.displayMedium!.color),
                ),
                SizedBox(height: 70),
                RoundedBorder(
                  color: theme.scaffoldBackgroundColor,
                  child: DefaultTextField(
                    maxLength: 12,
                    minLine: 1,
                    maxLine: 1,
                    fontSize: 16.0,
                    contentPadding: 16,
                    hintText: "이름를 입력해주세요.",
                    inputController: _controller,
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      )),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("다음",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}
