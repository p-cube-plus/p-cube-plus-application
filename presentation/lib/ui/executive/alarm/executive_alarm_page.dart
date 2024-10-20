import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_setting_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ExecutiveAlarmPage extends StatelessWidget {
  const ExecutiveAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "알림",
              style: TextStyle(
                fontSize: 20,
                color: theme.neutral100,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            RoundedBorder(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              onTap: () => _navigateToNotificationSettingPage(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "정기회의 알림",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.neutral100,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.neutral40,
                    size: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RoundedBorder(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              onTap: () => _navigateToNotificationSettingPage(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "파트회의 알림",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.neutral100,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.neutral40,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNotificationSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecutiveAlarmSettingPage(),
      ),
    );
  }
}
