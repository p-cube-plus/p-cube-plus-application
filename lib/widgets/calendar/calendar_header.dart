import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    Key? key,
    this.arrowButtonSize = 16.0,
    this.leftArrow,
    this.rightArrow,
    this.monthTextStyle,
    this.yearTextStyle,
    this.onArrowPressed,
    required this.date,
  }) : super(key: key);

  final TextStyle? monthTextStyle, yearTextStyle;
  final double arrowButtonSize;
  final Widget? leftArrow, rightArrow;
  final DateTime date;

  // int : 전 달 -> -1, 다음 달 -> 1
  final Function(int)? onArrowPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => onArrowPressed?.call(-1),
              child: Container(
                height: arrowButtonSize,
                width: arrowButtonSize,
                alignment: Alignment.center,
                child: leftArrow ?? Icon(Icons.chevron_left),
              ),
            ),
            Column(
              children: [
                SizedBox(height: arrowButtonSize / 4),
                Text("${DateFormat("M").format(date)}월", style: monthTextStyle),
                Text(DateFormat("yyyy").format(date), style: yearTextStyle),
              ],
            ),
            GestureDetector(
              onTap: () => onArrowPressed?.call(1),
              child: Container(
                height: arrowButtonSize,
                width: arrowButtonSize,
                alignment: Alignment.center,
                child: rightArrow ?? Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 18.0,
        ),
      ],
    );
  }
}
