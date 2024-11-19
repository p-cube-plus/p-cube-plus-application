import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/widgets/drag_detector.dart';
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
    return DragDetector(
      moveLeftContent: () =>
          read(context).triggerUiEvent(HomeScheduleEventScrollPreviousMonth()),
      moveRightContent: () =>
          read(context).triggerUiEvent(HomeScheduleEventScrollNextMonth()),
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
          ],
        ),
      ),
    );
  }
}
