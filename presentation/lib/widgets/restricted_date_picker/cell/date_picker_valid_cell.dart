import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/restricted_date_picker/restricted_date_picker_view_model.dart';

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              "$currentDay",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: theme.neutral100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(10, -10),
              child: Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primary80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
