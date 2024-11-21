import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/cell/date_picker_restricted_cell.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/cell/date_picker_selected_cell.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/cell/date_picker_today_cell.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/cell/date_picker_valid_cell.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/restricted_date_picker_view_model.dart';

class RestrictedDatePickerDay extends StatelessWidget
    with ViewModel<RestrictedDatePickerViewModel> {
  const RestrictedDatePickerDay({super.key});

  @override
  Widget build(BuildContext context) {
    return watchWidget((viewModel) => viewModel.currentDate,
        (context, currentMonth) {
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
                  return const Expanded(child: SizedBox(height: cellHeight));
                }

                return Expanded(
                  child: SizedBox(
                    height: cellHeight,
                    child: watchWidget(
                      (viewModel) => viewModel.selectedDay,
                      (context, selectedDay) {
                        if (createdDay == selectedDay.day) {
                          return RestrictedDatePickerSelectedCell(createdDay);
                        }
                        if (_isToday(currentMonth.year, currentMonth.month,
                            createdDay)) {
                          return RestrictedDatePickerTodayCell(createdDay);
                        }

                        if (read(context).isValidDay(createdDay)) {
                          return DatePickerValidCell(createdDay);
                        }
                        return DatePickerRestrictedCell(createdDay);
                      },
                      shouldRebuild: (previous, next) {
                        return previous.day != next.day;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
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
