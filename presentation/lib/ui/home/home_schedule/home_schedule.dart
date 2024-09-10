import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/home_calendar.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_viewmodel.dart';

import 'schedule_summary/calendar_summary_view.dart';
import '../home_upcomming/home_upcomming_schedule.dart';

class HomeSchedule extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const HomeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 24),
        HomeCalendar(),
        SizedBox(height: 16),
        CalendarSelectedDateSummaryView(),
      ],
    );
  }
}
