import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_setting_page.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ExecutivePartAlarmPage extends StatelessWidget {
  const ExecutivePartAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "파트회의 알림",
      ),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            MemberPartType.values.length,
            (index) {
              final partType = MemberPartType.values[index];
              return RoundedBorder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                onTap: () => _navigateToNotificationSettingPage(
                  context,
                  PartMettingNotification(partType),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${partType.korean} 파트",
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
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToNotificationSettingPage(
      BuildContext context, NotificationType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecutiveAlarmSettingPage(notificationType: type),
      ),
    );
  }
}
