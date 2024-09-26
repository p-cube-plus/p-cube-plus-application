import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/login/input_phone_number/input_phone_number_page_viewmodel.dart';
import 'package:presentation/ui/login/login_home_bottomsheet/login_home_bottomsheet_event.dart';
import 'package:presentation/ui/login/login_home_bottomsheet/login_home_buttomsheet_viewmodel.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/login/input_phone_number/login_phone_number_page.dart';
import 'package:provider/provider.dart';

class LoginHomeBottomsheet extends StatelessWidget {
  const LoginHomeBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginHomeBottomSheetViewModel(),
      child: const _LoginHomeBottomsheet(),
    );
  }
}

class _LoginHomeBottomsheet extends StatelessWidget
    with ViewModel<LoginHomeBottomSheetViewModel> {
  const _LoginHomeBottomsheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "잠깐,\n판도라큐브 회원이신가요?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: theme.neutral100,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "판도라큐브 회원이 아닌 경우 가입이 불가능해요.\nGuest 모드로 시작해 주세요.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral40,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: watchWidget<String>(
                        (viewModel) => viewModel.memberAgreedImagePath,
                        (memberAgreedImagePath) =>
                            SvgPicture.asset(memberAgreedImagePath))),
                Text(
                  "네, 판도라큐브 회원입니다.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral80,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => read(context)
              .triggerEvent(LoginHomeBottomSheetEvent.onClickMemberAgree),
        ),
        const SizedBox(height: 16),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: watchWidget<bool>(
              (viewModel) => viewModel.isMemberAgreed,
              (isMemberAgreed) => ElevatedButton(
                onPressed:
                    isMemberAgreed ? () => _onClickStartLogin(context) : null,
                onLongPress: null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: const Text(
                    "시작하기",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )),
        const SizedBox(height: 32),
      ],
    );
  }

  void _onClickStartLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPhoneNumberPage(),
      ),
    );
  }
}
