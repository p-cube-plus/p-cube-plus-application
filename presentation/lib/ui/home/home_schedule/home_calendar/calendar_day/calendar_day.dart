import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell_selected.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell_today.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_day/calendar_day_cell/calendar_day_cell_with_schedule.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/skeleton_animation_widget.dart';

import '../../home_schedule_viewmodel.dart';

class CalendarDay extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const CalendarDay({super.key});

  @override
  Widget build(BuildContext context) {
    return watchWidget(
      (viewModel) => viewModel.selectedDate,
      (context, currentMonth) {
        return DefaultFutureBuilder(
          fetchData: read(context).fetchHomeMonthSchedule(),
          showOnLoadedWidget: (context, monthSchedule) {
            return Column(
              children: List.generate(
                currentMonth.numberOfWeeks,
                growable: false,
                (columnIndex) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    DateTime.daysPerWeek,
                    growable: false,
                    (rowIndex) {
                      const cellHeight = 42.0;
                      final createdDay =
                          _getCreatedDay(currentMonth, columnIndex, rowIndex);

                      if (_isBlankCell(currentMonth, columnIndex, rowIndex)) {
                        return const Expanded(
                            child: SizedBox(height: cellHeight));
                      }

                      return Expanded(
                        child: SizedBox(
                          height: cellHeight,
                          child: watchWidget(
                            (viewModel) => viewModel.selectedDate.day,
                            (context, selectedDay) {
                              final schedule = monthSchedule[createdDay];
                              if (createdDay == selectedDay) {
                                return CalendarDayCellSelected(createdDay);
                              } else if (_isToday(currentMonth.year,
                                  currentMonth.month, createdDay)) {
                                return CalendarDayCellToday(createdDay);
                              } else if (schedule != null) {
                                return CalendarDayCellWithSchedule(
                                  createdDay,
                                  Color(schedule.type.color.hex),
                                );
                              }
                              return CalendarDayCell(createdDay);
                            },
                            shouldRebuild: (previous, next) {
                              return createdDay == previous ||
                                  createdDay == next;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          showOnLoadingWidget: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SkeletonAnimation(280, 195, radius: 10),
            );
          },
        );
      },
      shouldRebuild: (previous, next) {
        return previous.month != next.month;
      },
    );
  }

  bool _isToday(int year, int month, int day) {
    final today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }

  bool _isBlankCell(DateTime currentMonth, int columnIndex, int rowIndex) {
    final isStartBlank =
        columnIndex == 0 && rowIndex < currentMonth.firstDate.weekDayIndex;
    final isEndBlank = columnIndex == currentMonth.numberOfWeeks - 1 &&
        rowIndex > currentMonth.lastDate.weekDayIndex;
    return isStartBlank || isEndBlank;
  }

  int _getCreatedDay(DateTime currentDate, int columnIndex, int rowIndex) {
    return (columnIndex * DateTime.daysPerWeek + rowIndex) -
        currentDate.firstDate.weekDayIndex +
        1;
  }
}
