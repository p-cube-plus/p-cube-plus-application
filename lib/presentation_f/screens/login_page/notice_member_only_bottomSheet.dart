import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/common/utils/contants.dart';
import 'package:p_cube_plus_application/presentation_f/utils/pageUtil.dart';

import '../authentication_page/input_phone_number_page.dart';

class NoticeMemberOnlyBottomSheet extends StatefulWidget {
  @override
  State<NoticeMemberOnlyBottomSheet> createState() =>
      _NoticeMemberOnlyBottomSheetState();
}

class _NoticeMemberOnlyBottomSheetState
    extends State<NoticeMemberOnlyBottomSheet> {
  bool isCheckIcon = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "판도라큐브 회원이 아닌 경우 가입이 불가능해요.\nGuest 모드로 시작해 주세요.",
            style: TextStyle(color: theme.textTheme.displaySmall!.color),
          ),
        ),
        InkWell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      child: Constants.GetIcon(
                        isCheckIcon
                            ? Constants.selected_check_circle
                            : Constants.check_circle,
                        color: isCheckIcon
                            ? null
                            : theme
                                .bottomNavigationBarTheme.unselectedItemColor,
                      ),
                    ),
                  ),
                  Text(
                    "네, 판도라큐브 회원입니다.",
                    style:
                        TextStyle(color: theme.textTheme.headlineSmall!.color),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => setState(() => isCheckIcon = !isCheckIcon),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "시작하기",
                  style: isCheckIcon
                      ? theme.textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )
                      : theme.textTheme.headlineMedium!.copyWith(
                          fontSize: 16,
                          color: const Color(0xFFABABAB),
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ),
            ),
            onPressed: isCheckIcon
                ? PageUtil().push(context, InputPhoneNumberPage())
                : null,
            onLongPress: null,
          ),
        ),
      ],
    );
  }
}
