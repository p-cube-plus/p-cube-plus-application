import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/login_loading/login_loading_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

import 'input_name_page_viewmodel.dart';

class LoginNamePage extends StatelessWidget {
  final String phoneNumber;
  const LoginNamePage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNamePageViewModel(phoneNumber),
      child: const _LoginNamePage(),
    );
  }
}

class _LoginNamePage extends StatefulWidget {
  const _LoginNamePage();

  @override
  State<_LoginNamePage> createState() => _LoginNamePageState();
}

class _LoginNamePageState extends State<_LoginNamePage>
    with ViewModel<LoginNamePageViewModel> {
  final TextEditingController _textEditingcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingcontroller.addListener(() {
      read(context).saveName(_textEditingcontroller.text);
    });
  }

  @override
  void dispose() {
    _textEditingcontroller.dispose();
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
                "이름을 입력해주세요.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: theme.neutral100),
              ),
              const SizedBox(height: 8),
              Text(
                "회원 정보 조회 이외의 용도로 사용되지 않아요.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    color: theme.neutral60),
              ),
              const SizedBox(height: 70),
              RoundedBorder(
                hasShadow: false,
                border: Border.all(
                  color: theme.neutral10,
                  width: 1,
                ),
                child: DefaultTextField(
                  maxLength: 4,
                  minLine: 1,
                  maxLine: 1,
                  fontSize: 16.0,
                  contentPadding: 16,
                  hintText: "이름을 입력해주세요.",
                  inputController: _textEditingcontroller,
                  autofocus: true,
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
                  (viewModel) => viewModel.isNameAvailable,
                  (context, isNameAvailable) => ElevatedButton(
                    onPressed: isNameAvailable
                        ? () => _navigateToLoginLoadingPage()
                        : null,
                    onLongPress: null,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "다음",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
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

  void _navigateToLoginLoadingPage() {
    final phoneNumber = read(context).phoneNumber;
    final name = read(context).name;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginLoadingPage(
        phoneNumber: phoneNumber,
        name: name,
      ),
    ));
  }
}
