import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';
import 'package:p_cube_plus_application/widgets/calendar/Home/calendar_summary_view.dart';
import 'package:p_cube_plus_application/widgets/calendar/calendar.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    Key? key,
    required this.scheduleProvider,
  }) : super(key: key);

  final ScheduleProvider scheduleProvider;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarUpComingSummaryView(
          upCommingScheduleList: widget.scheduleProvider.getUpcomingSchedule(),
        ),
        Calendar(
            colorByDay: widget.scheduleProvider.getMonthSchedule(_selectedDate),
            selectedDate: _selectedDate,
            selectFunction: (newDate) =>
                setState(() => _selectedDate = newDate)),
        CalendarSelectedDateSummaryView(
          selectedDate: _selectedDate,
          todayScheduleList:
              widget.scheduleProvider.getSelectScheduleList(_selectedDate),
        )
      ]..add(SizedBox(height: 20.0)),
    );
  }
}
