import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';

import 'calendar_components/calendar_header.dart';
import 'calendar_components/calendar_week_row.dart';
import 'calendar_components/calender_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    required this.scheduleProvider,
    required this.selectedDate,
    required this.selectFunction,
    this.colorByDay = const {},
  }) : super(key: key);

  final DateTime selectedDate;
  final ScheduleProvider scheduleProvider;
  final Map<int, Color> colorByDay;
  final Function(DateTime) selectFunction;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();
  //GlobalKey _headerKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting("ko_KR");
  }

  @override
  Widget build(BuildContext context) {
    double startX = 0.0, endX = 0.0;

    return GestureDetector(
        onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
        onHorizontalDragUpdate: (details) => endX = details.localPosition.dx,
        onHorizontalDragEnd: (details) => _scrollAction(startX, endX),
        child: RoundedBorder(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CalendarHeader(
                      date: _currentDate,
                      onArrowPressed: (newMonth) => setState(() =>
                          _currentDate =
                              new DateTime(_currentDate.year, newMonth)),
                    ),
                    CalendarWeekRow(),
                    SizedBox(height: 8),
                    CalendarView(
                      scheduleProvider: widget.scheduleProvider,
                      currentDate: _currentDate,
                      selectedDate: widget.selectedDate,
                      selectFunction: widget.selectFunction,
                    )
                  ])),
        ));
  }

  void _scrollAction(double startX, double endX) {
    const double scrollSensitivity = 20.0;
    if (endX - startX > scrollSensitivity) {
      setState(() => _currentDate = new DateTime(
            _currentDate.year,
            _currentDate.month - 1,
          ));
    } else if (startX - endX > scrollSensitivity) {
      setState(() => _currentDate = new DateTime(
            _currentDate.year,
            _currentDate.month + 1,
          ));
    }
  }
}
