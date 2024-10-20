import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_event.dart';

import '../../../home_schedule_viewmodel.dart';

class CalendarDayCellToday extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  final int currentDay;

  const CalendarDayCellToday(
    this.currentDay, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => read(context)
          .triggerUiEvent(HomeScheduleEventOnClickCell(currentDay)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: 28.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.neutral40,
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
      ),
    );
  }
}
