import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_viewmodel.dart';
import 'package:presentation/ui/fee/month_fee_status_per_year/month_fee_status_widget.dart';
import 'package:presentation/ui/fee/skeleton_widget/month_fee_status_per_year_skeleton.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/drag_detector.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class MonthFeeStatusPerYearWidget extends StatefulWidget {
  const MonthFeeStatusPerYearWidget({super.key});

  @override
  State<MonthFeeStatusPerYearWidget> createState() =>
      _MonthFeeStatusPerYearWidgetState();
}

class _MonthFeeStatusPerYearWidgetState
    extends State<MonthFeeStatusPerYearWidget> with ViewModel<FeeViewModel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return watchWidget((viewModel) => viewModel.currentSelectedYear,
        (context, currentSelectedYear) {
      return DragDetector(
        moveLeftContent: () => read(context).selectPreviousYear(),
        moveRightContent: () => read(context).selectNextYear(),
        child: RoundedBorder(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => read(context).selectPreviousYear(),
                    child: SvgPicture.asset(
                      asset.left,
                      colorFilter: ColorFilter.mode(
                        theme.neutral60,
                        BlendMode.srcIn,
                      ),
                      width: 12,
                      height: 12,
                    ),
                  ),
                  Text(
                    "$currentSelectedYear년",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => read(context).selectNextYear(),
                    child: SvgPicture.asset(
                      asset.right,
                      colorFilter: ColorFilter.mode(
                        theme.neutral60,
                        BlendMode.srcIn,
                      ),
                      width: 12,
                      height: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              DefaultFutureBuilder(
                fetchData: read(context).fetchMonthFeeStatusPerYear(),
                showOnLoadedWidget: (context, monthFeeStatusList) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(6, (index) {
                          final data = monthFeeStatusList[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${data.month}월",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral40,
                                ),
                              ),
                              SizedBox(height: 4),
                              MonthFeeStatusWidget(data.feeStatusType),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(6, (index) {
                          final data = monthFeeStatusList[index + 6];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${data.month}월",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral40,
                                ),
                              ),
                              SizedBox(height: 4),
                              MonthFeeStatusWidget(data.feeStatusType),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 12),
                    ],
                  );
                },
                showOnLoadingWidget: (context) =>
                    MonthFeeStatusPerYearSkeleton(),
              )
            ],
          ),
        ),
      );
    });
  }
}
