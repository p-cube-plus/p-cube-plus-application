import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:provider/provider.dart';

import '../../providers/schedule_provider.dart';
import '../default/rounded_border_widget.dart';

class CalendarDailySummaryView extends StatelessWidget {
  const CalendarDailySummaryView({
    Key? key,
    required this.dayMarkColor,
    required this.selectedDate,
  }) : super(key: key);

  final List<Color> dayMarkColor;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    List<Schedule>? _schedules = context
        .watch<ScheduleProvider>()
        .dailySchedules[DateFormat.yMd().format(selectedDate)];

    bool _hasSchedule = false;
    List<Widget> _widgets = List.generate(
      _schedules?.length ?? 0,
      (index) {
        if (_schedules![index].hasSpan) return Container();
        _hasSchedule = true;

        return Padding(
          padding: EdgeInsets.only(top: 28.0 * index.sign),
          child: Row(
            children: [
              Container(
                height: 7.0,
                width: 7.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dayMarkColor[_schedules[index].type ?? 0]),
              ),
              SizedBox(width: 16.0),
              Text(
                DateFormat("a hh:mm", "ko_KR")
                    .format(_schedules[index].startDate ?? DateTime(0)),
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(width: 8.0),
              Text(
                _schedules[index].name,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        );
      },
    );

    if (!_hasSchedule) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: RoundedBorder(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat("yyyy.MM.dd").format(selectedDate),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: 16.0),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Column(children: _widgets),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarMonthlySummaryView extends StatelessWidget {
  const CalendarMonthlySummaryView({
    Key? key,
    required this.viewDate,
    required this.dayMarkColor,
  }) : super(key: key);

  final DateTime viewDate;
  final List<Color> dayMarkColor;

  @override
  Widget build(BuildContext context) {
    List<Schedule>? _schedules = context
        .watch<ScheduleProvider>()
        .monthlySchedules[DateFormat.yM().format(viewDate)];

    bool _hasSchedule = false;
    List<Widget> widgets = List.generate(
      _schedules?.length ?? 0,
      (index) {
        Schedule _schedule = _schedules![index];
        if (!_schedule.hasSpan && _schedule.startDate == null)
          return Container();

        DateTime start = _schedule.startDate!;
        DateTime end = _schedule.endDate ?? start;
        if (DateTime.now().isAfter(end)) return Container();

        bool span = _schedule.hasSpan &&
            !(start.day == end.day && start.difference(end).inDays <= 0);

        _hasSchedule = true;

        return Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: RoundedBorder(
            height: 48.0,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  height: 7.0,
                  width: 7.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dayMarkColor[_schedule.type ?? 0]),
                ),
                SizedBox(width: 12.0),
                Text(
                  "${DateFormat("yyyy.MM.dd").format(start)}" +
                      (span
                          ? "\n~ ${DateFormat("yyyy.MM.dd").format(end)}"
                          : ""),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(width: 8.0),
                Text(
                  _schedule.name,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (!_hasSchedule) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 28.0),
        Text(
          "다가오는 일정",
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: 8.0),
      ]..addAll(widgets),
    );
  }
}
