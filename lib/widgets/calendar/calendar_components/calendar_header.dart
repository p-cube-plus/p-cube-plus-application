import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/utils/contants.dart' as Constants;

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    Key? key,
    required this.onArrowPressed,
    required this.date,
  }) : super(key: key);

  final DateTime date;
  final Function(int) onArrowPressed;

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
              onTap: () => onArrowPressed(date.month - 1),
              child: Container(
                color: Colors.transparent,
                height: arrowButtonSize,
                width: arrowButtonSize * 3, // 원활한 터치를 위해 크기 키움
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 12.0,
                  width: 12.0,
                  child: Constants.Constants.GetIcon(
                    Constants.Constants.left_arrow,
                    color: theme.textTheme.displaySmall!.color,
                  ),
                ),
              ),
            ),
            // 스크롤을 오류를 없애기 위해 크기 최대
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text("${DateFormat("M").format(date)}월",
                        style: theme.textTheme.displayLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    Text(DateFormat("yyyy").format(date),
                        style: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onArrowPressed(date.month + 1),
              child: Container(
                height: arrowButtonSize,
                width: arrowButtonSize * 3, // 원활한 터치를 위해 크기 키움
                color: Colors.transparent,
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 12.0,
                  width: 12.0,
                  child: Constants.Constants.GetIcon(
                    Constants.Constants.right_arrow,
                    color: theme.textTheme.displaySmall!.color,
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
