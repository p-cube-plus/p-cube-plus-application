import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/date_time_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell_selected.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell_with_schedule.dart';

import '../../home_schedule_viewmodel.dart';

class CalendarDay extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const CalendarDay({super.key});

  @override
  Widget build(BuildContext context) {
    return watchWidget(
      (viewModel) => viewModel.currentDate,
      (currentDate) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            currentDate.numberOfWeeks,
            (columnIndex) => Row(
              children: List.generate(DateTime.daysPerWeek, (rowIndex) {
                final createdDay = _getCreatedDay(
                  currentDate,
                  columnIndex,
                  rowIndex,
                );

                if (isBlankCell(currentDate, columnIndex, rowIndex)) {
                  return const SizedBox();
                }

                return watchWidget(
                  (viewModel) => viewModel.currentDate.day,
                  (selectedDay) {
                    if (currentDate.day == selectedDay) {
                      return CalendarDayCellSelected(createdDay);
                    }
                    if (isSchduleCell(context, currentDate.day)) {
                      return CalendarDayCellWithSchedule(createdDay);
                    }
                    return CalendarDayCell(createdDay);
                  },
                  shouldRebuild: (previous, next) {
                    return createdDay == previous || createdDay == next;
                  },
                );
              }),
            ),
          ),
        );
      },
      shouldRebuild: (previous, next) {
        return previous.month != next.month;
      },
    );
  }

  bool isBlankCell(DateTime currentDate, int columnIndex, int rowIndex) {
    return rowIndex < currentDate.firstDateWeekday ||
        rowIndex > currentDate.lastDateWeekday;
  }

  bool isSchduleCell(BuildContext context, int day) {
    return read(context).scheduleColorList.containsKey(day);
  }

  int _getCreatedDay(DateTime currentDate, int columnIndex, int rowIndex) {
    return (columnIndex * DateTime.daysPerWeek + rowIndex) -
        currentDate.firstDateWeekday;
  }
}
