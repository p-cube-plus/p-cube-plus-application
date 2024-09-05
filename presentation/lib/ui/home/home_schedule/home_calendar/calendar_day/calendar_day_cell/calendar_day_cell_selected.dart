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
    return Expanded(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Container(
            height: 24.0,
            width: 24.0,
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
    ));
  }
}
