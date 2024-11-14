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
import 'package:provider/provider.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlarmViewModel(),
      child: _AlarmPage(),
    );
  }
}

class _AlarmPage extends StatelessWidget with ViewModel<AlarmViewModel> {
  const _AlarmPage();

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "알림",
      action: SvgPicture.asset(asset.setting),
      content: DefaultTabBar(
        overLayColor: Colors.transparent,
        tabAlignment: TabAlignment.center,
        padding: EdgeInsets.only(left: 16, bottom: 16),
        tabLabelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        indicatorInsets: EdgeInsets.symmetric(horizontal: 8),
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
