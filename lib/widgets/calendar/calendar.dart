import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:p_cube_plus_application/models/schedule.dart';

import '../../providers/schedule_provider.dart';
import 'calendar_header.dart';
import 'calendar_week_row.dart';
import 'calender_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    required this.scheduleProvider,
    this.onSelectedDateChanged,
    this.onViewDateChanged,
    this.isHomeCalendar = false,
  }) : super(key: key);

  final Function(DateTime)? onSelectedDateChanged;
  final Function(DateTime)? onViewDateChanged;
  final bool isHomeCalendar;
  final ScheduleProvider scheduleProvider;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _initialized = false;

  DateTime _selectedDate = DateTime.now();
  late DateTime _currentViewDate;
  CalendarView? _currentCalendar;

  GlobalKey _headerKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting("ko_KR");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _setDate(_selectedDate);
      _initialized = true;
      return Center(child: Text("불러오는중"));
    }
    late double startX, endX;

    // 달력 좌우 스크롤 액션
    return GestureDetector(
        onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
        onHorizontalDragUpdate: (details) {
          endX = details.localPosition.dx;
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            if (endX - startX > 20.0) {
              _setDate(new DateTime(
                _currentViewDate.year,
                _currentViewDate.month - 1,
              ));
            } else if (startX - endX > 20.0) {
              _setDate(new DateTime(
                _currentViewDate.year,
                _currentViewDate.month + 1,
              ));
            }
          });
        },
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalendarHeader(
                key: _headerKey,
                date: _currentViewDate,
                onArrowPressed: (delta) {
                  _setDate(new DateTime(
                    _currentViewDate.year,
                    _currentViewDate.month + delta,
                  ));
                },
              ),
              CalendarWeekRow(),
              SizedBox(height: 8),
              _currentCalendar!
            ]));
  }

  void _setDate(DateTime date) async {
    if (_initialized && date.month == _currentViewDate.month) return;
    _currentViewDate = date;

    Map<int, List<Schedule>> monthSchedule =
        await widget.scheduleProvider.getMonthSchedule(date.year, date.month);
    CalendarView result = CalendarView(
      currentYearMonth: _currentViewDate,
      selectedDate: _selectedDate,
      onSelectedDateChanged: widget.onSelectedDateChanged,
      monthSchedule: monthSchedule,
    );

    setState(() => _currentCalendar = result);
    widget.onViewDateChanged?.call(date);
  }
}
