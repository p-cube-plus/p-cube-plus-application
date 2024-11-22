import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/restricted_date_picker/restricted_date_picker_view_model.dart';

class DatePickerValidCell extends StatelessWidget
    with ViewModel<RestrictedDatePickerViewModel> {
  final int currentDay;

  const DatePickerValidCell(
    this.currentDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => read(context).changeSelectedDay(currentDay),
      child: Center(
        child: Text(
          "$currentDay",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: theme.neutral100,
          ),
        ),
      ),
    );
  }
}
