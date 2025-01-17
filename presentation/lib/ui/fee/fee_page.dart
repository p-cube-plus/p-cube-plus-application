import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/status_icon/status_late.dart';

class FeePage extends StatelessWidget {
  const FeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "회비",
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "이번 달 회비 납부",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 8),
            RoundedBorder(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  StatusLate(size: 72),
                  SizedBox(height: 16),
                  Text(
                    "회비 납부 완료!\n납부 기간을 꼭 지켜주세요.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "납부 기간",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral80,
                        ),
                      ),
                      Text(
                        "10월 6일 ~ 10월 13일",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral80,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "납부 금액",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral80,
                        ),
                      ),
                      Text(
                        "5,000원",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.neutral80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
