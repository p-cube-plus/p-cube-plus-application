import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_setting/notification_setting/notification_setting_view_model.dart';
import 'package:presentation/ui/user/user_setting/setting_tile/toggle_setting_tile.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class NotificationSettingPage extends StatelessWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationSettingViewModel(),
      child: _NotificationSettingPage(),
    );
  }
}

class _NotificationSettingPage extends StatelessWidget
    with ViewModel<NotificationSettingViewModel> {
  const _NotificationSettingPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(),
      title: "알림 설정",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultFutureBuilder(
            fetchData: read(context).fetchCanSendNotification(),
            showOnLoadedWidget: (context, data) {
              return ToggleSettingTile(
                title: "알림 허용",
                value: data,
                onChanged: (isOn) =>
                    read(context).updateCanSendNotification(isOn),
              );
            },
          ),
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
          DefaultFutureBuilder(
            fetchData: read(context)
                .fetchIsNotificationOn(RegularMettingNotification()),
            showOnLoadedWidget: (context, data) {
              return ToggleSettingTile(
                title: "정기회의 알림",
                value: data,
                onChanged: (isOn) {
                  read(context).updateIsNotificationOnUseCase(
                    RegularMettingNotification(),
                    isOn,
                  );
                },
              );
            },
          ),
          DefaultFutureBuilder(
            fetchData: read(context)
                .fetchIsNotificationOn(PartMettingNotification(null)),
            showOnLoadedWidget: (context, data) {
              return ToggleSettingTile(
                title: "파트회의 알림",
                value: data,
                onChanged: (isOn) {
                  read(context).updateIsNotificationOnUseCase(
                    PartMettingNotification(null),
                    isOn,
                  );
                },
              );
            },
          ),
          // Divider(
          //   color: theme.neutral10,
          //   indent: 20,
          //   endIndent: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, top: 16.0, bottom: 4),
          //   child: Text(
          //     "기타 알림",
          //     style: TextStyle(
          //       fontSize: 10,
          //       fontWeight: FontWeight.w400,
          //       color: theme.neutral60,
          //     ),
          //   ),
          // ),
          // DefaultFutureBuilder(
          //   fetchData: read(context).fetchIsNotificationOn(FeeNotification()),
          //   showOnLoadedWidget: (context, data) {
          //     return ToggleSettingTile(title: "회비회의 알림", value: data);
          //   },
          // ),
          // DefaultFutureBuilder(
          //   fetchData:
          //       read(context).fetchIsNotificationOn(CleaningNotification()),
          //   showOnLoadedWidget: (context, data) {
          //     return ToggleSettingTile(title: "청소 알림", value: data);
          //   },
          // ),
          // DefaultFutureBuilder(
          //   fetchData:
          //       read(context).fetchIsNotificationOn(CleaningNotification()),
          //   showOnLoadedWidget: (context, data) {
          //     return ToggleSettingTile(title: "대여 알림", value: data);
          //   },
          // ),
        ],
      ),
    );
  }
}
