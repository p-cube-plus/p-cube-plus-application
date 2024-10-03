import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class CalendarDayCellSelected extends StatelessWidget {
  final int currentDay;

  const CalendarDayCellSelected(
    this.currentDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            width: 28.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primary80,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$currentDay",
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
