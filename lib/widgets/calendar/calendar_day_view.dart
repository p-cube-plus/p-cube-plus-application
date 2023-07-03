import 'package:flutter/material.dart';

import '../../utilities/theme.dart';

class CalendarDayView extends StatelessWidget {
  const CalendarDayView({
    Key? key,
    required this.date,
    this.selected = false,
    this.onTap,
    this.decorateColor,
    this.selectedColor = MyThemes.primary80,
    this.isExecutive = false,
  }) : super(key: key);

  final DateTime date;
  final bool selected;
  final Function(DateTime)? onTap;
  final Color? decorateColor;
  final Color selectedColor;
  final bool isExecutive;

  @override
  Widget build(BuildContext context) {
    Widget view = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          date.day.toString(),
          style: selected
              ? TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                )
              : Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
        ),
        SizedBox(height: 2.0),
        Container(
          height: 4.0,
          width: 4.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !selected && decorateColor != null
                ? decorateColor
                : Colors.transparent,
          ),
        ),
      ],
    );

    return Expanded(
      child: InkWell(
        onTap: () => onTap?.call(date),
        child: Container(
          height: 38,
          child: selected
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Container(
                        height: 24.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedColor,
                        ),
                      ),
                    ),
                    view
                  ],
                )
              : view,
        ),
      ),
    );
  }
}
