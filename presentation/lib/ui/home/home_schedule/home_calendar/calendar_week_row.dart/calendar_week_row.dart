import 'package:flutter/material.dart';

import 'calendar_week_text.dart';

class CalendarWeekRow extends StatelessWidget {
  const CalendarWeekRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CalendarWeekText("일"),
        CalendarWeekText("월"),
        CalendarWeekText("화"),
        CalendarWeekText("수"),
        CalendarWeekText("목"),
        CalendarWeekText("금"),
        CalendarWeekText("토"),
      ],
    );
  }
}
