import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_tabbar.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class AlarmPage extends StatelessWidget {
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
            page: ListView.builder(
              padding: EdgeInsets.only(bottom: 8),
              itemCount: 25,
              itemBuilder: (context, index) {
                return AlarmListItem();
              },
            ),
          ),
          DefaultTab(
            tabName: "읽은 알림",
            page: ListView.builder(
              padding: EdgeInsets.only(bottom: 8),
              itemCount: 25,
              itemBuilder: (context, index) {
                return AlarmListItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AlarmListItem extends StatelessWidget {
  const AlarmListItem({super.key});

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
                        "회의 알림",
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
                  "오늘 13시에 정기회의가 시작됩니다.",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral100,
                  ),
                ),
                Text(
                  "HH:mm",
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
