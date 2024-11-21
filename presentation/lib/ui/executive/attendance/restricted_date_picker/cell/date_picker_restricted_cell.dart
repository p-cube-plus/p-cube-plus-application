import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DatePickerRestrictedCell extends StatelessWidget {
  final int currentDay;

  const DatePickerRestrictedCell(
    this.currentDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => {},
      child: Center(
        child: Text(
          "$currentDay",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: theme.neutral20,
          ),
        ),
      ),
    );
  }
}
