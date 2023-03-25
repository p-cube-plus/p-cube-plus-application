import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/calendar/calendar_header.dart';
import '../../../widgets/calendar/calendar_week_row.dart';
import '../../../widgets/page/default_appbar.dart';
import '../../../widgets/page/default_content.dart';
import '../../../widgets/page/default_page.dart';

class CleaningNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: "청소 알림",
      ),
      content: DefaultContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalendarHeader(date: DateTime.now()),
            CalendarWeekRow(),
          ],
        ),
      ),
    );
  }
}
