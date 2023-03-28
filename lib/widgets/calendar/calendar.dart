import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/schedule_provider.dart';
import 'calendar_header.dart';
import 'calendar_week_row.dart';
import 'calender_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    this.onSelectedDateChanged,
    this.onViewDateChanged,
    this.isHomeCalendar = false,
  }) : super(key: key);

  final Function(DateTime)? onSelectedDateChanged;
  final Function(DateTime)? onViewDateChanged;
  final bool isHomeCalendar;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _initialized = false;

  late DateTime _viewDate;
  DateTime _selectedDate = DateTime.now();
  late Map<String, CalendarView> _calendars;
  CalendarView? _currentCalendar;

  GlobalKey _headerKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 한국어 Localization 데이터 가져오기.
    initializeDateFormatting("ko_KR");
  }

  @override
  void initState() {
    super.initState();
    _calendars = <String, CalendarView>{};
  }

  void _setDate(DateTime date) async {
    if (_initialized && date.month == _viewDate.month) return;
    _viewDate = date;

    await context.read<ScheduleProvider>().loadSchedules(_viewDate);
    CalendarView result = await _getCalendar(date);

    setState(() => _currentCalendar = result);
    widget.onViewDateChanged?.call(date);
    _initialized = true;
  }

  Future<CalendarView> _getCalendar(DateTime date) async {
    String yMDate = DateFormat.yM().format(date);
    if (_calendars.containsKey(yMDate)) return _calendars[yMDate]!;

    _calendars[yMDate] = CalendarView(
      date: date,
      selectedDate: _selectedDate,
      onSelectedDateChanged: widget.onSelectedDateChanged,
      isHomeCalendar: widget.isHomeCalendar,
    );

    return _calendars[yMDate]!;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _setDate(_selectedDate);
      return Center(child: Text("불러오는중"));
    }
    late double startX, endX;

    return GestureDetector(
      onHorizontalDragStart: (details) => startX = details.globalPosition.dx,
      onHorizontalDragUpdate: (details) {
        endX = details.localPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          if (endX - startX > 20.0) {
            _setDate(new DateTime(
              _viewDate.year,
              _viewDate.month - 1,
            ));
          } else if (startX - endX > 20.0) {
            _setDate(new DateTime(
              _viewDate.year,
              _viewDate.month + 1,
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
              date: _viewDate,
              onArrowPressed: (delta) {
                setState(() {
                  _setDate(new DateTime(
                    _viewDate.year,
                    _viewDate.month + delta,
                  ));
                });
              },
            ),
            CalendarWeekRow(),
            SizedBox(height: 8),
            _currentCalendar!
          ]),
    );
  }
}
