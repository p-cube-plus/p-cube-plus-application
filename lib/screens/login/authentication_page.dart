import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:p_cube_plus_application/models/login/confirm_info.dart';
import 'package:p_cube_plus_application/models/login/request_info.dart';
import 'package:p_cube_plus_application/models/login/user_info.dart';
import 'package:p_cube_plus_application/screens/main_page.dart';
import 'package:p_cube_plus_application/services/oauth_api.dart';
import 'package:p_cube_plus_application/utilities/phone_number_tool.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';
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
  String? phoneNumber, cookie;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isReadyPhoneNumber
        ? isAuthenticatedPhoneNumber
            ? InputNamePage(phoneNumber: phoneNumber)
            : AuthenticationPhoneNumberPage(
                cookie: cookie,
                authenticationSuccess: () =>
                    setState(() => isAuthenticatedPhoneNumber = true))
        : InputPhoneNumberPage(clickAuthentication: (_phoneNumber, _cookie) {
            setState(() => isReadyPhoneNumber = true);
            phoneNumber = _phoneNumber;
            cookie = _cookie;
          });
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
    var requestApi = new OAuthRequestApi();

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
                    maxLength: 14,
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
                  onPressed: () async {
                    var phoneNumber = _controller.text.trim();
                    var isPhoneNumber =
                        PhoneNumberTool.isPhoneNumber(phoneNumber);
                    if (!isPhoneNumber) {
                      Fluttertoast.showToast(
                        msg: "올바른 전화번호를 입력해주세요 :)",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    }

                    Fluttertoast.showToast(
                      msg: "인증번호를 발송하고 있어요 :)",
                      toastLength: Toast.LENGTH_SHORT,
                    );

                    RequestInfo requestInfo = await requestApi
                        .post(body: {"phone_number": phoneNumber});
                    if (requestInfo.isValid)
                      clickAuthentication(phoneNumber, requestInfo.cookie);
                    else
                      Fluttertoast.showToast(
                        msg: "인증번호 발송에 실패했어요 :(",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                  },
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
  const AuthenticationPhoneNumberPage({
    required this.authenticationSuccess,
    required this.cookie,
  });
  final Function authenticationSuccess;
  final String? cookie;
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
  bool isAvailRequest = false;

  @override
  void initState() {
    super.initState();
    setState(() => timeoutText = getTimeoutText());

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (isInvalidInput) timer.cancel();

      timeoutCount -= const Duration(seconds: 1);
      setState(() => timeoutText = getTimeoutText());

      if (!isAvailRequest)
        setState(() => isAvailRequest =
            timeoutCount <= const Duration(minutes: 2, seconds: 45));

      if (timeoutCount == const Duration(minutes: 0, seconds: 0)) {
        setState(() => timeoutText = "인증 시간이 만료되었어요 :(");
        timer.cancel();
      }
    });

    var confirmApi = OAuthConfirmApi();
    _controller.addListener(
      () async {
        if (_controller.text.length == 6) {
          ConfirmInfo confirmInfo = await confirmApi.post(
            additionalHeader: {"cookie": widget.cookie.toString()},
            body: {"code": _controller.text.trim()},
          );

          if (!confirmInfo.isVerified) {
            Fluttertoast.showToast(
              msg: "본인 인증에 실패했어요 :(",
              toastLength: Toast.LENGTH_SHORT,
            );
            return;
          }
          // TODO: timer memory leak issue
          widget.authenticationSuccess();
        }
      },
    );
  }

  String getTimeoutText() =>
      '${timeoutCount.inMinutes}:${(timeoutCount.inSeconds % 60).toString().padLeft(2, '0')}';

  void invalidAuthentication() {
    isInvalidInput = true;
    setState(() => timeoutText = "잘못된 인증번호에요 :(");
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
                      onPressed: () => isAvailRequest
                          ? setState(() => _controller.text = "")
                          : null,
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
  final String? phoneNumber;

  InputNamePage({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var userApi = OAuthUserApi();
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
                  onPressed: () async {
                    Fluttertoast.showToast(
                      msg: "로그인을 시도하고 있어요 :)",
                      toastLength: Toast.LENGTH_LONG,
                    );
                    UserInfo userInfo = await userApi.post(
                      body: {
                        "name": _controller.text.trim(),
                        "phone_number": phoneNumber.toString(),
                        "fcm_token":
                            await FirebaseMessaging.instance.getToken(),
                      },
                    );
                    if (!userInfo.isMember) {
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                        msg: "판도라큐브 회원만 로그인 할 수 있어요 :(\n" +
                            "회원이어도 지속적으로 실패한다면 문의해주세요 :)",
                        toastLength: Toast.LENGTH_LONG,
                      );
                      return;
                    }

                    await TokenManager()
                        .setAccessToken(userInfo.accessToken.toString());
                    await TokenManager()
                        .setRefreshToken(userInfo.refreshToken.toString());

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                      (route) => false,
                    );
                  },
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
