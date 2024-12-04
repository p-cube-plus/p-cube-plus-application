import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/rounded_border.dart';

class MemberFilterBottomSheet extends StatelessWidget {
  const MemberFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 32),
          child: Text(
            "필터",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "회원 분류",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        DefaultToggleTile(
          title: "활동 회원만 보기",
          value: true,
          background: theme.background,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 24),
          child: Text(
            "정렬",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        RoundedBorder(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          color: Colors.transparent,
          radius: 40,
          hasBorder: true,
          child: Row(
            children: [
              Expanded(
                child: RoundedBorder(
                  radius: 40,
                  color: theme.primary10,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "이름 순",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.primary80,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RoundedBorder(
                  radius: 40,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "회원구분 순",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: ElevatedButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "필터 적용하기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
