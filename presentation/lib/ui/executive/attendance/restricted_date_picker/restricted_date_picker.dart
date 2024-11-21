import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/restricted_date_picker_day.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/restricted_date_picker_view_model.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_week_row.dart/calendar_week_row.dart';
import 'package:presentation/widgets/drag_detector.dart';
import 'package:provider/provider.dart';

class RestrictedDatePicker extends StatelessWidget {
  const RestrictedDatePicker({
    super.key,
    required this.onDateSelectionComplete,
  });

  final Function(DateTime) onDateSelectionComplete;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestrictedDatePickerViewModel(onDateSelectionComplete),
      child: _RestrictedDatePicker(),
    );
  }
}

class _RestrictedDatePicker extends StatelessWidget
    with ViewModel<RestrictedDatePickerViewModel> {
  const _RestrictedDatePicker();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: DragDetector(
        moveLeftContent: () => read(context).movePreviousMonth(),
        moveRightContent: () => read(context).moveNextMonth(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "날짜 선택하기",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => read(context).movePreviousMonth(),
                    child: Icon(
                      Icons.chevron_left,
                      color: theme.neutral40,
                      size: 24,
                    ),
                  ),
                ),
                watchWidget((viewModel) => viewModel.currentDate,
                    (context, selectedDate) {
                  return Text(
                    selectedDate.format("yyyy년 M월"),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  );
                }),
                Expanded(
                  child: GestureDetector(
                    onTap: () => read(context).moveNextMonth(),
                    child: Icon(
                      Icons.chevron_right,
                      color: theme.neutral40,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CalendarWeekRow(),
            RestrictedDatePickerDay(),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => read(context).onDateSelect(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "해당 날짜 선택하기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.neutral40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
