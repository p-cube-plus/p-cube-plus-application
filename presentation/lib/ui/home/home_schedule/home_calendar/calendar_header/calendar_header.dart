import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import '../../home_schedule_viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class CalendarHeader extends StatelessWidget
    with ViewModel<HomeScheduleViewmodel> {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => read(context).jumpToOneMonthAgo(),
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 16),
                child: SvgPicture.asset(
                  asset.left,
                  colorFilter: ColorFilter.mode(
                    theme.neutral60,
                    BlendMode.srcIn,
                  ),
                  width: 12,
                  height: 12,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              watchWidget(
                (viewModel) => viewModel.selectedDate.month,
                (context, currentMonth) {
                  return Text(
                    "$currentMonth월",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  );
                },
              ),
              watchWidget(
                (viewModel) => viewModel.selectedDate.year,
                (context, currentYear) {
                  return Text(
                    "$currentYear년",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral40,
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => read(context).jumpToOneMonthLater(),
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(right: 16),
                child: SvgPicture.asset(
                  asset.right,
                  colorFilter: ColorFilter.mode(
                    theme.neutral60,
                    BlendMode.srcIn,
                  ),
                  width: 12,
                  height: 12,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
