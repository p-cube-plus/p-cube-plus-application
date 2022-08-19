import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/providers/schedule_provider.dart';

import '../../models/schedule.dart';
import 'calendar_header.dart';
import 'calendar_week_row.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    this.headerArrowButtonSize = 16.0,
    this.headerLeftArrow,
    this.headerRightArrow,
    this.headerMonthTextStyle,
    this.headerYearTextStyle,
    this.weekDayTextStyle,
    this.weekDayHeight,
    this.dayHeight,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.daySelectedColor,
    this.firstDayOfWeek = 0,
    required this.dayMarkColor,
    this.onSelectedDateChanged,
    this.onViewDateChanged,
  }) : super(key: key);

  final double headerArrowButtonSize;
  final Widget? headerLeftArrow, headerRightArrow;
  final TextStyle? headerMonthTextStyle, headerYearTextStyle;

  final double? weekDayHeight;
  final TextStyle? weekDayTextStyle;

  final double? dayHeight;
  final TextStyle? dayTextStyle, selectedDayTextStyle;
  final int firstDayOfWeek;

  final Color? daySelectedColor;
  final List<Color> dayMarkColor;

  final Function(DateTime)? onSelectedDateChanged;
  final Function(DateTime)? onViewDateChanged;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _initialized = false;

  late DateTime _viewDate;
  DateTime _selectedDate = DateTime.now();
  late Map<String, Widget> _calendars;
  Widget? _currentCalendar = null;

  bool _dragFlag = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 한국어 Localization 데이터 가져오기.
    initializeDateFormatting("ko_KR");
  }

  @override
  void initState() {
    super.initState();

    _calendars = <String, Widget>{};
  }

  void _setDate(DateTime date) async {
    if (_initialized && date.month == _viewDate.month) return;
    _viewDate = date;

    await context.read<ScheduleProvider>().loadSchedules(_viewDate);
    Widget result = await _getCalendar(date);
    _getCalendar(new DateTime(date.year, date.month - 1));
    _getCalendar(new DateTime(date.year, date.month + 1));

    setState(() => _currentCalendar = result);
    widget.onViewDateChanged?.call(date);
  }

  Future<Widget> _getCalendar(DateTime date) async {
    String yMDate = DateFormat.yM().format(date);
    if (_calendars.containsKey(yMDate)) return _calendars[yMDate]!;
    print(yMDate);
    var _schedules = context.read<ScheduleProvider>().monthlySchedules[yMDate];

    _calendars[yMDate] = CalendarView(
      date: date,
      firstDayOfWeek: widget.firstDayOfWeek,
      dayHeight: widget.dayHeight,
      dayTextStyle: widget.dayTextStyle,
      selectedDayTextStyle: widget.selectedDayTextStyle,
      daySelectedColor: widget.daySelectedColor,
      selectedDate: _selectedDate,
      schedules: _schedules,
      dayMarkColor: widget.dayMarkColor,
      onSelectedDateChanged: widget.onSelectedDateChanged,
    );

    return _calendars[yMDate]!;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _setDate(_selectedDate);
      _initialized = true;
    }

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (_dragFlag) return;

        double sensitivity = 16.0;
        _dragFlag = details.delta.dx.abs() > sensitivity;

        if (!_dragFlag) return;
        setState(() {
          _setDate(new DateTime(
            _viewDate.year,
            _viewDate.month - details.delta.dx.sign.toInt(),
          ));
        });
      },
      onHorizontalDragEnd: (detail) => _dragFlag = false,
      child: Container(
        width: double.infinity,
        //height: double.infinity,
        //color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: CalendarHeader(
                date: _viewDate,
                arrowButtonSize: widget.headerArrowButtonSize,
                leftArrow: widget.headerLeftArrow,
                rightArrow: widget.headerRightArrow,
                monthTextStyle: widget.headerMonthTextStyle,
                yearTextStyle: widget.headerYearTextStyle,
                onArrowPressed: (delta) {
                  setState(() {
                    _setDate(new DateTime(
                      _viewDate.year,
                      _viewDate.month + delta,
                    ));
                  });
                },
              ),
            ),
            Container(
              height: widget.weekDayHeight,
              child: CalendarWeekRow(
                weekDayTextStyle: widget.weekDayTextStyle,
                firstDayOfWeek: widget.firstDayOfWeek,
              ),
            ),
          ]..addAll(_currentCalendar != null ? [_currentCalendar!] : []),
        ),
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({
    Key? key,
    required this.date,
    this.firstDayOfWeek = 0,
    this.dayHeight,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.schedules,
    this.selectedDate,
    this.daySelectedColor,
    required this.dayMarkColor,
    this.onSelectedDateChanged,
  }) : super(key: key);

  final DateTime date;
  final int firstDayOfWeek;
  final double? dayHeight;
  final Color? daySelectedColor;
  final TextStyle? dayTextStyle, selectedDayTextStyle;
  final List<Schedule>? schedules;
  final DateTime? selectedDate;
  final List<Color> dayMarkColor;
  final Function(DateTime)? onSelectedDateChanged;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> days = _getDays(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        days.length ~/ 7,
        (i) => Row(
          children: List.generate(7, (j) => days[i * 7 + j]),
        ),
      ),
    );
  }

  List<Widget> _getDays(BuildContext context) {
    List<Widget> days = <Widget>[];
    Widget _blank = Expanded(child: Container(height: widget.dayHeight));

    DateTime itr = widget.date.add(Duration(days: -widget.date.day + 1));

    // 앞 부분 공백
    for (int i = 0; i < (itr.weekday - widget.firstDayOfWeek) % 7; i++)
      days.add(_blank);

    // 날짜들
    while (itr.month == widget.date.month) {
      days.add(CalendarDayView(
        date: itr,
        height: widget.dayHeight,
        dayTextStyle: widget.dayTextStyle,
        selectedDayTextStyle: widget.selectedDayTextStyle,
        schedules: context
            .read<ScheduleProvider>()
            .dailySchedules[DateFormat.yMd().format(itr)],
        selected: itr.day == _selectedDate.day &&
            itr.difference(_selectedDate).inDays == 0,
        selectedColor: widget.daySelectedColor,
        markColor: widget.dayMarkColor,
        onTap: (date) {
          setState(() {
            _selectedDate = date;
            widget.onSelectedDateChanged?.call(date);
          });
        },
      ));
      itr = itr.add(const Duration(days: 1));
    }

    // 뒷 부분 공백
    int blanks = 7 - days.length % 7;
    for (int i = 0; i < blanks; i++) days.add(_blank);

    return days;
  }
}

class CalendarDayView extends StatelessWidget {
  const CalendarDayView({
    Key? key,
    required this.date,
    this.height,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.schedules,
    this.selected = false,
    this.selectedColor,
    required this.markColor,
    this.onTap,
  }) : super(key: key);

  final DateTime date;
  final double? height;
  final TextStyle? dayTextStyle, selectedDayTextStyle;
  final List<Schedule>? schedules;
  final bool selected;
  final Color? selectedColor;
  final List<Color> markColor;
  final Function(DateTime)? onTap;

  @override
  Widget build(BuildContext context) {
    Widget view = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          date.day.toString(),
          style: selected ? selectedDayTextStyle : dayTextStyle,
        ),
        Container(
          height: 4.0,
          width: 4.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !selected && schedules != null
                ? markColor[schedules?[0].type ?? 0]
                : Colors.transparent,
          ),
        ),
      ],
    );

    return Expanded(
      child: InkWell(
        onTap: () => onTap?.call(date),
        child: Container(
          height: height,
          child: selected
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Container(
                        height: 24.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedColor,
                        ),
                      ),
                    ),
                    view
                  ],
                )
              : view,
        ),
      ),
    );
  }
}
