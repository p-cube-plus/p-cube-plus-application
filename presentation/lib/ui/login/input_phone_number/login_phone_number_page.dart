import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/input_phone_number/input_phone_number_event.dart';
import 'package:presentation/ui/login/input_phone_number/input_phone_number_state.dart';
import 'package:presentation/utils/phone_number_formatter.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/login/input_auth_number/login_auth_number_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

import 'input_phone_number_page_viewmodel.dart';

class LoginPhoneNumberPage extends StatelessWidget {
  const LoginPhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginPhoneNumberPageViewModel(),
      child: const _LoginPhoneNumberPage(),
    );
  }
}

class _LoginPhoneNumberPage extends StatefulWidget {
  const _LoginPhoneNumberPage();

  @override
  State<_LoginPhoneNumberPage> createState() => _LoginPhoneNumberPageState();
}

class _LoginPhoneNumberPageState extends State<_LoginPhoneNumberPage>
    with ViewModel<LoginPhoneNumberPageViewModel> {
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
        appbar: const DefaultAppBar(),
        resizeToAvoidBottomInset: true,
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
                  color: theme.neutral100,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "회원 정보 조회 이외의 용도로 사용되지 않아요.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  color: theme.neutral60,
                ),
              ),
              const SizedBox(height: 70),
              RoundedBorder(
                hasShadow: false,
                border: Border.all(
                  color: theme.neutral10,
                  width: 1,
                ),
                child: DefaultTextField(
                  maxLength: 13,
                  minLine: 1,
                  maxLine: 1,
                  fontSize: 16.0,
                  contentPadding: 16,
                  hintText: "전화번호를 입력해주세요.",
                  textType: TextInputType.number,
                  autofocus: true,
                  inputController: _textEditController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PhoneNumberFormatter(),
                  ],
                  onChanged: (inputText) =>
                      read(context).triggerUiEvent(TextChanged(inputText)),
                ),
              ),
            ],
          ),
        ),
        bottomContent: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: watchWidget<bool>(
                  (viewModel) => viewModel.canClickRequestAuth,
                  (context, canClickRequestAuth) => ElevatedButton(
                    onPressed: canClickRequestAuth
                        ? () => _navigateToInputAuthNumberPage()
                        : null,
                    onLongPress: null,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "인증 요청하기",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  void _setStateListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case InputPhoneNumberState.navigateToAuth:
          _navigateToInputAuthNumberPage();
      }
    });
  }

  void _navigateToInputAuthNumberPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginAuthNumberPage(
          phoneNumber: _textEditController.text,
        ),
      ),
    );
  }
}
