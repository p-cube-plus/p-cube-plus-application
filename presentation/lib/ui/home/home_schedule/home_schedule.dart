import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/home_calendar.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_viewmodel.dart';
import 'package:provider/provider.dart';

import 'schedule_summary/calendar_summary_view.dart';

class HomeSchedule extends StatelessWidget {
  const HomeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScheduleViewmodel(),
      child: const _HomeSchedule(),
    );
  }
}

class _HomeSchedule extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const _HomeSchedule();

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
