import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_viewmodel.dart';
import 'package:presentation/widgets/rounded_border.dart';

class CalendarSelectedDateSummaryView extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const CalendarSelectedDateSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return watchWidget<DateTime>(
      (viewModel) => viewModel.selectedDate,
      (selectedDate) {
        return watchWidget(
          (viewModel) => viewModel.todayScheduleList,
          (scheduleList) {
            if (scheduleList.isEmpty) return const SizedBox();
            return RoundedBorder(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    read(context).selectedDate.format("yyyy.MM.dd"),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral60,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Positioned(
                        left: 3,
                        top: 7.5,
                        child: Container(
                          color: theme.neutral20,
                          height: (scheduleList.length - 1) * 44.0,
                          width: 1,
                        ),
                      ),
                      Column(
                          children: List.generate(
                        scheduleList.length,
                        growable: false,
                        (index) {
                          final scheduleData = scheduleList[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 29.0 * index.sign),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 7.0,
                                  width: 7.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(
                                      scheduleData.type.color.hex,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  scheduleData.scheduleDate.format("a hh:mm"),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: theme.neutral60,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  scheduleData.title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: theme.neutral100,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
