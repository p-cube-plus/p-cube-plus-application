import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import '../../common/rounded_border.dart';

class CalendarSelectedDateSummaryView extends StatelessWidget {
  const CalendarSelectedDateSummaryView({
    Key? key,
    required this.selectedDate,
    required this.todaySchedule,
  }) : super(key: key);

  final DateTime selectedDate;
  final List<Schedule> todaySchedule;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = List.generate(
      todaySchedule.length,
      (index) {
        return Padding(
          padding: EdgeInsets.only(top: 28.0 * index.sign),
          child: Row(
            children: [
              Container(
                height: 7.0,
                width: 7.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: todaySchedule[index].getMarkColor()),
              ),
              SizedBox(width: 16.0),
              Text(
                DateFormat("a hh:mm", "ko_KR").format(
                    selectedDate.day == todaySchedule[index].startDate?.day
                        ? todaySchedule[index].startDate ?? DateTime(0)
                        : DateTime(0)),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(width: 8.0),
              Text(
                todaySchedule[index].title,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        );
      },
    );

    if (todaySchedule.isEmpty) return Container();

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
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: 16.0),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  left: 3,
                  top: 9,
                  child: Container(
                    color: Theme.of(context).dialogBackgroundColor,
                    height: (todaySchedule.length - 1) * 42.0,
                    width: 1,
                  ),
                ),
                Column(children: _widgets),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarUpComingSummaryView extends StatelessWidget {
  const CalendarUpComingSummaryView({
    Key? key,
    required this.scheduleList,
  }) : super(key: key);

  final List<Schedule> scheduleList;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.generate(
      scheduleList.length,
      (index) {
        Schedule _schedule = scheduleList[index];
        DateTime start = _schedule.startDate!;
        DateTime end = _schedule.endDate ?? start;

        bool isMoreThanOneDay =
            !(start.day == end.day && start.difference(end).inDays <= 0);

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
                      color: scheduleList[index].getMarkColor()),
                ),
                SizedBox(width: 12.0),
                Text(
                  "${DateFormat("yyyy.MM.dd").format(start)}" +
                      (isMoreThanOneDay
                          ? "\n~ ${DateFormat("yyyy.MM.dd").format(end)}"
                          : ""),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(width: 8.0),
                Text(
                  _schedule.title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
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

    if (scheduleList.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "다가오는 일정",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: 8.0),
      ]..addAll(widgets),
    );
  }
}
