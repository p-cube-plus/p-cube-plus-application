import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/drag_detector.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/widgets/status_icon/status_blank.dart';
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
            SizedBox(height: 40),
            Text(
              "연도별 회비 납부",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 8),
            RoundedBorder(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  DragDetector(
                    moveLeftContent: () {},
                    moveRightContent: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.navigate_before_rounded,
                          size: 20,
                          color: theme.neutral100,
                        ),
                        Text(
                          "2025년",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.neutral100,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 20,
                          color: theme.neutral100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(6, (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1}월",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral40,
                                ),
                              ),
                              SizedBox(height: 4),
                              StatusBlank(size: 32),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(6, (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 7}월",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral40,
                                ),
                              ),
                              SizedBox(height: 4),
                              StatusBlank(size: 32),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 12),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Text(
              "회비 내역",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 8),
            RoundedBorder(
              padding:
                  EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    "1,200,340원",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral100,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "자세히 보기",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.neutral40,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    size: 24,
                    color: theme.neutral40,
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
