import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/restricted_date_picker/restricted_date_picker_day.dart';
import 'package:presentation/widgets/restricted_date_picker/restricted_date_picker_view_model.dart';
import 'package:presentation/ui/home/home_schedule/home_calendar/calendar_week_row.dart/calendar_week_row.dart';
import 'package:presentation/widgets/drag_detector.dart';
import 'package:provider/provider.dart';

class RestrictedDatePicker extends StatelessWidget {
  const RestrictedDatePicker({
    super.key,
    required this.targetYear,
    required this.targetMonth,
    required this.onDateSelectionComplete,
    required this.fetchRefreshValidDates,
  });

  final int targetYear;
  final int targetMonth;
  final Function(DateTime) onDateSelectionComplete;
  final Future<List<int>> Function(DateTime) fetchRefreshValidDates;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestrictedDatePickerViewModel(
        targetYear,
        targetMonth,
        onDateSelectionComplete,
        fetchRefreshValidDates,
      ),
      child: _RestrictedDatePicker(),
    );
  }
}

class _RestrictedDatePicker extends StatefulWidget
    with ViewModel<RestrictedDatePickerViewModel> {
  const _RestrictedDatePicker();

  @override
  State<_RestrictedDatePicker> createState() => _RestrictedDatePickerState();
}

class _RestrictedDatePickerState extends State<_RestrictedDatePicker> {
  var _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: DragDetector(
        moveLeftContent: () => _movePreviousMonth(),
        moveRightContent: () => _moveNextMonth(),
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
                    onTap: () => _movePreviousMonth(),
                    child: Icon(
                      Icons.chevron_left,
                      color: theme.neutral40,
                      size: 24,
                    ),
                  ),
                ),
                widget.watchWidget((viewModel) => viewModel.currentDate,
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
                    onTap: () => _moveNextMonth(),
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
            RestrictedDatePickerDay(
              key: _refreshKey,
            ),
            SizedBox(height: 32),
            widget.watchWidget(
              (viewModel) => viewModel.selectedDay,
              (context, selectedDay) {
                return ElevatedButton(
                  onPressed: onDateSelectionComplete(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "해당 날짜 선택하기",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _movePreviousMonth() {
    widget.read(context).movePreviousMonth();
    setState(() => _refreshKey = UniqueKey());
  }

  void _moveNextMonth() {
    widget.read(context).moveNextMonth();
    setState(() => _refreshKey = UniqueKey());
  }

  void Function()? onDateSelectionComplete() {
    final selectedDay = widget.read(context).selectedDay;
    final currentDate = widget.read(context).currentDate;
    if (selectedDay == null || !selectedDay.isSameMonth(currentDate)) {
      return null;
    }
    return () => widget.read(context).onDateSelectionComplete(selectedDay);
  }
}
