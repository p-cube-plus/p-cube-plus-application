import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';
import 'package:p_cube_plus_application/screens/guest/guest_notion_webview_page.dart';
import 'package:p_cube_plus_application/widgets/calendar/home_calendar.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import 'package:provider/provider.dart';

class GuestHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scheduleProvider = context.watch<ScheduleProvider>();

    return DefaultPage(
      title: "홈",
      content: DefaultRefreshIndicator(
        refreshFunction: scheduleProvider.refresh(),
        child: DefaultFutureBuilder(
          fetchData: scheduleProvider.fetch(),
          showFunction: (data) => DefaultContent(
            child: Column(
              children: [
                IntroducePcubeTile(),
                SizedBox(height: 40),
                HomeCalendar(
                  scheduleProvider: scheduleProvider,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroducePcubeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "판도라큐브 소개",
          style: theme.textTheme.displayLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        RoundedBorder(
          width: double.infinity,
          height: 56,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuestWebViewPage()),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "판도라큐브 소개 바로가기",
                style: theme.textTheme.displayLarge!
                    .copyWith(fontSize: 14.0, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  Icon(Icons.chevron_right,
                      size: 24.0, color: theme.textTheme.displayMedium!.color)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
