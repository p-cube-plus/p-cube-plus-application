import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/alarm/alarm_viewmodel.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AlarmPage extends StatelessWidget with ViewModel<AlarmViewModel> {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "알림",
      action: SvgPicture.asset(asset.setting),
      content: DefaultTabBar(
        tabAlignment: TabAlignment.center,
        padding: EdgeInsets.only(left: 20, bottom: 16),
        tabLabelPadding: EdgeInsets.only(left: 4, right: 20, top: 4, bottom: 4),
        indicatorInsets: EdgeInsets.only(right: 16),
        tabs: [
          DefaultTab(
            tabName: "새 알림",
            page: DefaultFutureBuilder(
              fetchData: read(context).fetchNewNotification(),
              showOnLoadedWidget: (context, data) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 8),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AlarmListItem(data: data[index]);
                  },
                );
              },
            ),
          ),
          DefaultTab(
            tabName: "읽은 알림",
            page: DefaultFutureBuilder(
              fetchData: read(context).fetchReadNotification(),
              showOnLoadedWidget: (context, data) {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 8),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AlarmListItem(data: data[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AlarmListItem extends StatelessWidget {
  const AlarmListItem({super.key, required this.data});

  final NotificationData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RoundedBorder(
      color: theme.neutral0,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: theme.neutral100,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -4,
                  right: 0,
                  child: SvgPicture.asset(
                    asset.cancel,
                    width: 8,
                    height: 8,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.description,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral100,
                  ),
                ),
                Text(
                  data.date.format("yyyy.MM.dd HH:mm"),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
