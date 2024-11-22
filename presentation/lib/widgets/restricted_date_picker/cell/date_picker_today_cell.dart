import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class RestrictedDatePickerTodayCell extends StatelessWidget {
  final int currentDay;

  const RestrictedDatePickerTodayCell(
    this.currentDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => {},
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              width: 28.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primary10,
              ),
            ),
          ),
          Text(
            "$currentDay",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: theme.primary60,
            ),
          ),
          Positioned(
            bottom: -5,
            child: Text(
              "오늘",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: theme.primary60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
