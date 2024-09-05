import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class CalendarWeekText extends StatelessWidget {
  final String text;
  const CalendarWeekText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: theme.neutral40,
      ),
    );
  }
}
