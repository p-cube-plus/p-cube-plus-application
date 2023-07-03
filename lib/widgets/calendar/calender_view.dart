import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:provider/provider.dart';
import '../../providers/schedule_provider.dart';
import 'calendar_day_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({
    Key? key,
    required this.date,
    this.selectedDate,
    this.onSelectedDateChanged,
    this.isHomeCalendar = false,
  }) : super(key: key);

  final DateTime date;
  final DateTime? selectedDate;
  final Function(DateTime)? onSelectedDateChanged;
  final isHomeCalendar;

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
    //final _height = (days.length ~/ 7) * (widget.dayHeight ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        days.length ~/ 7,
        (i) => Container(
          child: Row(
            children: List.generate(7, (j) => days[i * 7 + j]),
          ),
        ),
      ),
    );
  }

  List<Widget> _getDays(BuildContext context) {
    List<Widget> days = <Widget>[];
    ScheduleProvider? scheduleProvider;
    if (widget.isHomeCalendar) {
      scheduleProvider = context.read<ScheduleProvider>();
    }
    Widget _blank = Expanded(child: Container());
    DateTime itr = widget.date.add(Duration(days: -widget.date.day + 1));

    // 앞 부분 공백
    for (int i = 0; i < itr.weekday % 7; i++) days.add(_blank);

    // 날짜들
    while (itr.month == widget.date.month) {
      days.add(CalendarDayView(
          date: itr,
          selected: itr.year == DateTime.now().year &&
                  itr.month == DateTime.now().month &&
                  itr.day == DateTime.now().day ||
              itr.day == _selectedDate.day &&
                  itr.difference(_selectedDate).inDays == 0,
          selectedColor: itr != widget.date ||
                  (itr.day == _selectedDate.day &&
                      itr.difference(_selectedDate).inDays == 0)
              ? MyThemes.primary80
              : Theme.of(context).dialogBackgroundColor,
          onTap: (date) {
            setState(() {
              _selectedDate = date;
              widget.onSelectedDateChanged?.call(date);
            });
          },
          decorateColor: scheduleProvider
              ?.dailySchedules[DateFormat.yMd().format(itr)]?[0]
              .getMarkColor()));
      itr = itr.add(const Duration(days: 1));
    }

    // 뒷 부분 공백
    int blanks = (7 - days.length % 7) % 7;
    for (int i = 0; i < blanks; i++) days.add(_blank);

    return days;
  }
}
