import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'calendar_day_cell.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({
    Key? key,
    required this.colorByDay,
    required this.currentDate,
    required this.selectedDate,
    required this.selectFunction,
  }) : super(key: key);

  final Map<int, Color> colorByDay;
  final DateTime currentDate;
  final DateTime selectedDate;
  final Function(DateTime) selectFunction;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getCalendarView();
  }

  Widget _getCalendarView() {
    var calendarCellWidgetList = _getCalendarCellWidgetList();
    int rowCount = calendarCellWidgetList.length ~/ 7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        rowCount,
        (i) => Container(
          child: Row(
            children:
                List.generate(7, (j) => calendarCellWidgetList[i * 7 + j]),
          ),
        ),
      ),
    );
  }

  List<Widget> _getCalendarCellWidgetList() {
    List<Widget> result = <Widget>[];
    DateTime startDate =
        DateTime(widget.currentDate.year, widget.currentDate.month, 1);

    result.addAll(_getStartBlankWidgets(startDate));
    result.addAll(_getCalendarCellWidgets(startDate));
    result.addAll(_getEndBlankWidgets(result));

    return result;
  }

  List<Widget> _getStartBlankWidgets(DateTime startDate) {
    List<Widget> result = [];
    int beforeDateStart = startDate.weekday % 7;

    for (int i = 0; i < beforeDateStart; i++) result.add(_getBlankCellWidget());
    return result;
  }

  List<Widget> _getCalendarCellWidgets(DateTime startDate) {
    List<Widget> result = [];

    while (startDate.month == widget.currentDate.month) {
      Color selectedColor = startDate.year == DateTime.now().year &&
              startDate.month == DateTime.now().month &&
              startDate.day == DateTime.now().day &&
              startDate.difference(widget.selectedDate).inDays != 0
          ? Theme.of(context).dialogBackgroundColor
          : MyThemes.primary80;

      result.add(CalendarDayView(
          date: startDate,
          selected: startDate.year == DateTime.now().year &&
                  startDate.month == DateTime.now().month &&
                  startDate.day == DateTime.now().day ||
              startDate.day == widget.selectedDate.day &&
                  startDate.difference(widget.selectedDate).inDays == 0,
          selectedColor: selectedColor,
          onTap: (date) => widget.selectFunction(date),
          decorateColor: widget.colorByDay[startDate.day]));
      startDate = startDate.add(const Duration(days: 1));
    }

    return result;
  }

  List<Widget> _getEndBlankWidgets(List<Widget> currentCellList) {
    List<Widget> result = [];
    int requiredBlanksCount = (7 - currentCellList.length % 7) % 7;

    for (int i = 0; i < requiredBlanksCount; i++)
      result.add(_getBlankCellWidget());
    return result;
  }

  Widget _getBlankCellWidget() => Expanded(
          child: Container(
        height: 36,
        color: Colors.transparent,
      ));
}
