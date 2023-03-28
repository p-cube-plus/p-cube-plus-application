import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utilities/contants.dart' as Constants;

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    Key? key,
    this.onArrowPressed,
    required this.date,
  }) : super(key: key);

  final DateTime date;
  final Function(int)? onArrowPressed;

  @override
  Widget build(BuildContext context) {
    final double arrowButtonSize = 40;
    final theme = Theme.of(context);
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
                child: SizedBox(
                  height: 12.0,
                  width: 12.0,
                  child: Constants.Icons.GetIcon(
                    Constants.Icons.left_arrow,
                    color: theme.textTheme.headline3!.color,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 10),
                Text("${DateFormat("M").format(date)}월",
                    style: theme.textTheme.headline1!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
                Text(DateFormat("yyyy").format(date),
                    style: theme.textTheme.headline3!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
            GestureDetector(
              onTap: () => onArrowPressed?.call(1),
              child: Container(
                height: arrowButtonSize,
                width: arrowButtonSize,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 12.0,
                  width: 12.0,
                  child: Constants.Icons.GetIcon(
                    Constants.Icons.right_arrow,
                    color: theme.textTheme.headline3!.color,
                  ),
                ),
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
