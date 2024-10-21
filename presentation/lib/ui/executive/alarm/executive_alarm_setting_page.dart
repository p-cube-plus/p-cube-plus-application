import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_setting_viewmodel.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ExecutiveAlarmSettingPage extends StatelessWidget
    with ViewModel<ExecutiveAlarmSettingViewModel> {
  ExecutiveAlarmSettingPage({super.key, required this.notificationType});

  final NotificationType notificationType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "정기회의 알림",
      ),
      content: DefaultContent(
        child: Column(
          children: [
            DefaultFutureBuilder(
              fetchData:
                  read(context).fetchNotificationSettingOn(notificationType),
              showOnLoadedWidget: (isOn) {
                return DefaultToggleTile(
                  title: "알림 켜짐",
                  value: true,
                  onChanged: (bool isOn) {},
                );
              },
            ),
            const SizedBox(height: 16),
            DefaultFutureBuilder(
              fetchData:
                  read(context).fetchNotificationSettingHour(notificationType),
              showOnLoadedWidget: (alarmTime) {
                return RoundedBorder(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "회의",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.neutral60,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "$alarmTime시간 전",
                        style: TextStyle(
                          fontSize: 22,
                          color: theme.neutral100,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomContent: ElevatedButton(
        onPressed: () {},
        child: Text(
          "확인",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
