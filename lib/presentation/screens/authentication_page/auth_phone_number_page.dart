import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_cube_plus_application/common/utils/contants.dart';
import 'package:p_cube_plus_application/common/utils/theme.dart';
import 'package:p_cube_plus_application/presentation/utils/pageUtil.dart';
import 'package:p_cube_plus_application/presentation/viewmodels/auth_page_viewmodel.dart';
import 'package:p_cube_plus_application/widgets/common/default_alert.dart';
import 'package:p_cube_plus_application/widgets/common/default_textField.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

import 'input_name_page.dart';

class AuthenticationPhoneNumberPage extends StatefulWidget {
  const AuthenticationPhoneNumberPage();
  @override
  State<AuthenticationPhoneNumberPage> createState() =>
      _AuthenticationPhoneNumberPageState();
}

class _AuthenticationPhoneNumberPageState
    extends State<AuthenticationPhoneNumberPage> {
  final _viewModel = AuthPageViewModel();
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  Duration timeoutCount = Duration(minutes: 3);
  String timeoutText = "";

  @override
  void initState() {
    super.initState();

    setState(() => timeoutText = getTimeoutText());
    _controller.addListener(editController);
  }

  void editController() async {
    if (_controller.text.length == 6) {
      var isVerified = await _viewModel.isVerified();

      if (isVerified) {
        Fluttertoast.showToast(
          msg: "본인 인증에 성공했어요 :)",
          toastLength: Toast.LENGTH_SHORT,
        );
        PageUtil().pushAndRemoveUntil(context, InputNamePage());
      } else {
        _timer?.cancel();
        _viewModel.isNeedToRetry = true;
        setState(() => timeoutText = "잘못된 인증번호에요.");
        DialogBuilder().build(
          context,
          DefaultAlert(
            title: "본인 인증에 실패했어요.",
            description: "다시 시도해주세요.",
            messageType: MessageType.OK,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String getTimeoutText() =>
      '${timeoutCount.inMinutes}:${(timeoutCount.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    _viewModel.initData(context);
    _requestAuth();
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
              Constants.GetIcon(Constants.watch),
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
                      autofocus: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                      onPressed:
                          _viewModel.isNeedToRetry ? () => _requestAuth : null,
                      onLongPress: null,
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

  Future<void> _requestAuth() async {
    _timer = _getTimer();

    Fluttertoast.showToast(
      msg: "인증번호를 발송하고 있어요 :)",
      toastLength: Toast.LENGTH_SHORT,
    );

    var isSuccess = await _viewModel.sendAuthNumberAndGetIsSuccess();
    Fluttertoast.cancel();

    if (isSuccess) {
      Fluttertoast.showToast(
        msg: "인증번호가 발송되었어요 :)",
        toastLength: Toast.LENGTH_SHORT,
      );
      _controller.text = _viewModel.data.authCode;
    } else {
      showDialog(
        context: context,
        builder: (context) => DefaultAlert(
          title: "인증번호 발송에 실패했어요 :(",
          description: "다시 시도해주세요 :)",
          messageType: MessageType.OK,
        ),
      );
    }
  }

  Timer _getTimer() {
    return Timer.periodic(Duration(seconds: 1), (Timer timer) {
      timeoutCount -= const Duration(seconds: 1);
      setState(() => timeoutText = getTimeoutText());

      if (timeoutCount == const Duration(minutes: 2, seconds: 45)) {
        _viewModel.isNeedToRetry = true;
      }

      if (timeoutCount == const Duration(minutes: 0, seconds: 0)) {
        setState(() => timeoutText = "인증 시간이 만료되었어요.");
        timer.cancel();
      }
    });
  }
}
