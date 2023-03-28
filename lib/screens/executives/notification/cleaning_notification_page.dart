import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_cube_plus_application/widgets/calendar/calendar.dart';

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
          children: [CleaningCalendar()],
        ),
      ),
    );
  }
}

class CleaningCalendar extends StatefulWidget {
  @override
  State<CleaningCalendar> createState() => _CleaningCalendarState();
}

class _CleaningCalendarState extends State<CleaningCalendar> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Calendar(
      onSelectedDateChanged: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }
}
