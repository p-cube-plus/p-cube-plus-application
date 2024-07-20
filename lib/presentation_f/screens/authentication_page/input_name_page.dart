import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_cube_plus_application/presentation_f/utils/pageUtil.dart';
import 'package:p_cube_plus_application/presentation_f/viewmodels/auth_page_viewmodel.dart';
import 'package:p_cube_plus_application/widgets/common/default_alert.dart';
import 'package:p_cube_plus_application/widgets/common/default_textField.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

import '../main_page/main_page.dart';

class InputNamePage extends StatefulWidget {
  @override
  State<InputNamePage> createState() => _InputNamePageState();
}

class _InputNamePageState extends State<InputNamePage> {
  final _viewModel = AuthPageViewModel();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isNameAvailable = false;

  @override
  void initState() {
    _controller.addListener(
      checkNameAvailable,
    );
    super.initState();
  }

  void checkNameAvailable() {
    setState(() => isNameAvailable = _controller.text.length >= 2);
  }

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
                    autofocus: true,
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
                  onPressed: isNameAvailable ? () => onClickLogin : null,
                  onLongPress: null,
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

  Future<void> onClickLogin() async {
    Fluttertoast.showToast(
      msg: "로그인을 시도하고 있어요 :)",
      toastLength: Toast.LENGTH_LONG,
    );

    var isSuccess = await _viewModel.tryLogin(_controller.text);

    Fluttertoast.cancel();
    if (!isSuccess) {
      DialogBuilder().build(
          context,
          DefaultAlert(
            title: "인증에 실패했어요 :(",
            description:
                "판도라큐브 회원만 로그인 할 수 있어요 :(\n" + "회원이어도 지속적으로 실패한다면 문의해주세요 :)",
            messageType: MessageType.OK,
          ));
      return;
    }

    Fluttertoast.showToast(
      msg: "로그인에 성공했어요 :)",
      toastLength: Toast.LENGTH_SHORT,
    );

    PageUtil().pushAndRemoveUntil(context, MainPage());
  }
}
