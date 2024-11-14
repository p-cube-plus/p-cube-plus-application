import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/attendance/attendance_today_page/attendance_today/attendance_today.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class UserWarningPage extends StatelessWidget {
  const UserWarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "경고 현황",
      appbar: DefaultAppBar(),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "주의 및 경고",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
                Text(
                  "1.5회",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "경고 차감",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
                Text(
                  "2회",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "총",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: theme.neutral60,
                  ),
                ),
                Text(
                  "0회",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: theme.neutral100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Divider(
              height: 1,
              color: theme.neutral10,
            ),
            SizedBox(height: 24),
            Text(
              "주의 및 경고 내역",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: theme.neutral60,
              ),
            ),
            Column(
              children: List.generate(5, (index) {
                return RoundedBorder(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "주의",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: theme.neutral100,
                            ),
                          ),
                          Text(
                            "정기회의 지각",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: theme.neutral40,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateTime.now().format("yyyy.MM.dd"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral40,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 32),
            Text(
              "경고 차감 내역",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: theme.neutral60,
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: List.generate(3, (index) {
                return RoundedBorder(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "경고 차감",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: theme.neutral100,
                            ),
                          ),
                          Text(
                            "대청소 참여",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: theme.neutral40,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateTime.now().format("yyyy.MM.dd"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.neutral40,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
