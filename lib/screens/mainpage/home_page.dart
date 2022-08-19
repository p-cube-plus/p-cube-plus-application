import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/providers/schedule_provider.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import 'package:provider/provider.dart';
import '../../utilities/contants.dart' as Constants;
import '../../widgets/calendar/calendar.dart';
import '../../widgets/calendar/calendar_summary_view.dart';
import '../../widgets/default_page_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme currentTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScheduleProvider>(
          create: (_) => ScheduleProvider(),
        ),
      ],
      child: DefaultPage(
        appBarTitle: "홈",
        content: HomeCalendar(
          currentTheme: currentTheme,
        ),
      ),
    );
  }
}

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    Key? key,
    required this.currentTheme,
  }) : super(key: key);

  final TextTheme currentTheme;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _viewDate = DateTime.now();

  List<Color> _dayMarkColor = const [
    Color(0xC9DE2B13),
    Color(0xFF3ABDAD),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedBorder(
          radius: 10.0,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Calendar(
            headerArrowButtonSize: 40.0,
            headerLeftArrow: SizedBox(
              height: 12.0,
              width: 12.0,
              child: Constants.Icons.GetIcon(
                Constants.Icons.left_arrow,
                color: widget.currentTheme.headline3!.color,
              ),
            ),
            headerRightArrow: SizedBox(
              height: 12.0,
              width: 12.0,
              child: Constants.Icons.GetIcon(
                Constants.Icons.right_arrow,
                color: widget.currentTheme.headline3!.color,
              ),
            ),
            headerMonthTextStyle: widget.currentTheme.headline1!.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            headerYearTextStyle: widget.currentTheme.headline3!.copyWith(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
            ),
            weekDayHeight: 20.0,
            weekDayTextStyle: widget.currentTheme.headline3!.copyWith(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
            ),
            dayHeight: 38.0,
            dayTextStyle: widget.currentTheme.headline1!.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
            ),
            selectedDayTextStyle: widget.currentTheme.headline1!.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            //firstDayOfWeek: 1,
            daySelectedColor: _dayMarkColor[0],
            dayMarkColor: _dayMarkColor,
            onSelectedDateChanged: (date) =>
                setState(() => _selectedDate = date),
            onViewDateChanged: (date) => setState(() {
              _viewDate = date;
            }),
          ),
        ),
        if (_viewDate.month == _selectedDate.month &&
            _viewDate.difference(_selectedDate).inDays.abs() < 32)
          CalendarDailySummaryView(
            dayMarkColor: _dayMarkColor,
            selectedDate: _selectedDate,
          )
        else
          Container(),
      ]
        ..add(
          CalendarMonthlySummaryView(
            viewDate: _viewDate,
            dayMarkColor: _dayMarkColor,
          ),
        )
        ..add(SizedBox(height: 20.0)),
    );
  }
}
