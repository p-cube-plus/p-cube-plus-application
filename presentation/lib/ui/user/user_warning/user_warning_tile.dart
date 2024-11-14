import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_warning/user_warning_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class UserWarningTile extends StatelessWidget {
  const UserWarningTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "경고 현황",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            GestureDetector(
              onTap: () => _navigateToDetailPage(context),
              child: Row(
                children: [
                  Text(
                    "자세히 보기",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral60,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.neutral60,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        RoundedBorder(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "누적 경고 횟수",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral100,
                ),
              ),
              Text(
                "총 n회",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: theme.primary80,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToDetailPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserWarningPage()));
  }
}
