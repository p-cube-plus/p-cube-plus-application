import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/widgets/rounded_border.dart';

import 'calendar_day/calendar_day.dart';
import 'calendar_header/calendar_header.dart';
import 'calendar_week_row.dart/calendar_week_row.dart';
import '../home_schedule_event.dart';
import '../home_schedule_viewmodel.dart';

class HomeCalendar extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const HomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    double startX = 0.0;
    double positionX = 0.0;

    return GestureDetector(
        onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
        onHorizontalDragUpdate: (details) =>
            positionX = details.localPosition.dx,
        onHorizontalDragEnd: (details) =>
            _scrollAction(context, startX, positionX),
        child: const RoundedBorder(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalendarHeader(),
                SizedBox(height: 16),
                CalendarWeekRow(),
                SizedBox(height: 8),
                CalendarDay(),
              ]),
        ));
  }

  void _scrollAction(BuildContext context, double startX, double endX) {
    const double scrollSensitivity = 20.0;
    if (endX - startX > scrollSensitivity) {
      read(context).triggerUiEvent(HomeScheduleEventScrollPreviousMonth());
    } else if (startX - endX > scrollSensitivity) {
      read(context).triggerUiEvent(HomeScheduleEventScrollNextMonth());
    }
  }
}
