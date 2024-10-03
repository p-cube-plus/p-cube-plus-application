import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class CalendarWeekRow extends StatelessWidget {
  const CalendarWeekRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final weekNameList = ["일", "월", "화", "수", "목", "금", "토"];
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        DateTime.daysPerWeek,
        growable: false,
        (index) {
          return Expanded(
            child: Text(
              textAlign: TextAlign.center,
              weekNameList[index],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: theme.neutral40,
              ),
            ),
          );
        },
      ),
    );
  }
}
