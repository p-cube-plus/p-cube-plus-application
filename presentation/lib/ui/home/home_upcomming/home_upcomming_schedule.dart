import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_future_builder.dart';

import 'home_upcomming_schedule_viewmodel.dart';
import 'upcomming_schedule/upcomming_schedule_item/home_upcomming_schedule_item.dart';

class HomeUpcommingSchedule extends StatelessWidget
    with ViewModel<HomeUpcommingScheduleViewModel> {
  const HomeUpcommingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "다가오는 일정",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: theme.neutral100,
          ),
        ),
        const SizedBox(height: 8),
        DefaultFutureBuilder(
          fetchData: read(context).fetchData(),
          showOnLoadedWidget: (data) {
            return Column(
              children: List.generate(
                data.length,
                (index) {
                  return HomeUpcommingScheduleItem(
                    data[index],
                  );
                },
                growable: false,
              ),
            );
          },
        ),
      ],
    );
  }
}
