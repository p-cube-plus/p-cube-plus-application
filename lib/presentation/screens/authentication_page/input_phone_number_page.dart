import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:p_cube_plus_application/presentation/utils/pageUtil.dart';
import 'package:p_cube_plus_application/presentation/viewmodels/auth_page_viewmodel.dart';
import 'package:p_cube_plus_application/widgets/common/default_textField.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';

import 'auth_phone_number_page.dart';

class InputPhoneNumberPage extends StatelessWidget {
  final viewModel = AuthPageViewModel();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    viewModel.initData(context);
    _controller.addListener(viewModel.savePhoneNumber);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: DefaultPage(
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
                  inputFormatters: [
                    MultiMaskedTextInputFormatter(
                      masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'],
                      separator: '-',
                    )
                  ],
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
                onPressed:
                    viewModel.isPhoneNumber ? () => onPressAuthButton : null,
                onLongPress: null,
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
    );
  }

  Future<void> onPressAuthButton(BuildContext context) async {
    Fluttertoast.showToast(
      msg: "인증번호를 발송하고 있어요 :)",
      toastLength: Toast.LENGTH_SHORT,
    );

    PageUtil().push(context, AuthenticationPhoneNumberPage());

    // if (isSuccess) {
    //   Fluttertoast.showToast(
    //     msg: "인증번호가 발송되었어요 :)",
    //     toastLength: Toast.LENGTH_SHORT,
    //   );

    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (context) => DefaultAlert(
    //       title: "인증번호 발송에 실패했어요 :(",
    //       description: "다시 시도해주세요 :)",
    //       messageType: MessageType.OK,
    //     ),
    //   );
    // }
  }
}
