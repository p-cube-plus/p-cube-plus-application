import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/toggle_setting_tile.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';

class UserAlarmPage extends StatelessWidget {
  const UserAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "알림 설정",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToggleSettingTile(title: "알림 허용", value: true),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 16.0, bottom: 4),
            child: Text(
              "회의 알림",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: theme.neutral60,
              ),
            ),
          ),
          ToggleSettingTile(title: "정기회의 알림", value: true),
          ToggleSettingTile(title: "파트회의 알림", value: true),
          Divider(
            color: theme.neutral10,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 16.0, bottom: 4),
            child: Text(
              "기타 알림",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: theme.neutral60,
              ),
            ),
          ),
          ToggleSettingTile(title: "회비회의 알림", value: true),
          ToggleSettingTile(title: "청소 알림", value: true),
          ToggleSettingTile(title: "도서 대여 알림", value: true),
        ],
      ),
    );
  }
}
