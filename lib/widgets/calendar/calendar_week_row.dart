import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWeekRow extends StatelessWidget {
  const CalendarWeekRow({
    Key? key,
    this.firstDayOfWeek = 0,
    this.weekDayTextStyle,
  }) : super(key: key);

  final int firstDayOfWeek;
  final TextStyle? weekDayTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return Expanded(
          child: Container(
            child: Center(
              child: Text(
                DateFormat('E', "ko_KR")
                    .dateSymbols
                    .SHORTWEEKDAYS[(index + firstDayOfWeek) % 7],
                style: weekDayTextStyle,
              ),
            ),
          ),
        );
      }),
    );
  }
}
