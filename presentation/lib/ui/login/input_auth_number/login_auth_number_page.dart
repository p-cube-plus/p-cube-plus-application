import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/input_auth_number/input_auth_number_state.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/login/input_user_name/login_name_page.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';
import 'package:presentation/constants/asset_path.dart' as path;

import 'input_auth_number_page_viewmodel.dart';

class LoginAuthNumberPage extends StatelessWidget {
  final String phoneNumber;
  const LoginAuthNumberPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginAuthNumberPageViewModel(phoneNumber),
      child: const _LoginAuthNumberPage(),
    );
  }
}

class _LoginAuthNumberPage extends StatefulWidget {
  const _LoginAuthNumberPage();

  @override
  State<_LoginAuthNumberPage> createState() => _LoginAuthNumberPageState();
}

class _LoginAuthNumberPageState extends State<_LoginAuthNumberPage>
    with ViewModel<LoginAuthNumberPageViewModel> {
  final TextEditingController _textEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _setStateListener();
    });
  }

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus
          ?.unfocus(disposition: UnfocusDisposition.scope),
      child: DefaultPage(
        resizeToAvoidBottomInset: true,
        appbar: const DefaultAppBar(),
        content: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "인증번호가 발송되었어요.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: theme.neutral100,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "인증번호가 발송되지 않은 경우\n재요청 버튼을 눌러주세요.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: theme.neutral60),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(path.timeoutWatch),
                    const SizedBox(width: 4),
                    watchWidget<String>(
                        (viewModel) => viewModel.timerText,
                        (context, timerText) => Text(
                              timerText,
                              style: TextStyle(
                                color: theme.primary80,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ))
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RoundedBorder(
                        height: 48,
                        hasShadow: false,
                        border: Border.all(
                          color: theme.neutral10,
                          width: 1,
                        ),
                        child: watchWidget<bool>(
                          (viewModel) => viewModel.isFailedInputAuth,
                          (context, isNeedToRetry) => DefaultTextField(
                            maxLength: 6,
                            minLine: 1,
                            maxLine: 1,
                            fontSize: 16.0,
                            contentPadding: 16,
                            hintText: "인증번호 입력",
                            textType: TextInputType.number,
                            inputController: _textEditController,
                            onChanged: (inputText) => read(context)
                                .onChangedInputAuthNumber(inputText),
                            autofocus: true,
                            enabled: !isNeedToRetry,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    watchWidget<bool>(
                        (viewModel) => viewModel.isNeedToRetry,
                        (context, isNeedToRetry) => ElevatedButton(
                            onPressed: isNeedToRetry
                                ? () => read(context).requestAuth()
                                : null,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("재요청"),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setStateListener() {
    read(context).uiEventStream.listen((event) {
      switch (event) {
        case InputAuthNumberState.showSendingAuthNumberToast:
          _showSendingAuthNumberToast();
        case InputAuthNumberState.showFailedSendAuthNumberDialog:
          _showFailedSendAuthNumberDialog();
        case InputAuthNumberState.checkIsValidAuthNumber:
          _showLoadingDialog();
        case InputAuthNumberState.completeVerification:
          _closeLoadingDialog();
        case InputAuthNumberState.validAuthNumber:
          _showSuccessVerificationToast();
          _navigateToLoginNamePage();
        case InputAuthNumberState.invalidAuthNumber:
          _showFailedVerificationDialog();
      }
    });
  }

  void _showSendingAuthNumberToast() {
    Fluttertoast.showToast(
      msg: "인증번호를 발송하고 있어요 :)",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _showFailedSendAuthNumberDialog() {
    showDialog(
      context: context,
      builder: (context) => const DefaultAlert(
        title: "인증번호 발송에 실패했어요 :(",
        description: "다시 시도해주세요 :)",
        messageType: MessageType.ok,
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _closeLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _showSuccessVerificationToast() {
    Fluttertoast.showToast(
      msg: "본인 인증에 성공했어요 :)",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _navigateToLoginNamePage() {
    final phoneNumber = read(context).phoneNumner;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginNamePage(
          phoneNumber: phoneNumber,
        ),
      ),
      (route) => route.isFirst,
    );
  }

  void _showFailedVerificationDialog() {
    _textEditController.text = "";
    DialogBuilder().build(
      context,
      const DefaultAlert(
        title: "인증에 실패했어요.",
        description: "다시 시도해주세요.",
        messageType: MessageType.ok,
      ),
    );
  }
}
