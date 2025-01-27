import 'package:domain/fee/value_object/fee_status_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/fee/current_month_fee/current_month_fee_status/current_month_fee_failed.dart';
import 'package:presentation/ui/fee/current_month_fee/current_month_fee_status/current_month_fee_late.dart';
import 'package:presentation/ui/fee/current_month_fee/current_month_fee_status/current_month_fee_pending_not_date.dart';
import 'package:presentation/ui/fee/current_month_fee/current_month_fee_status/current_month_fee_pending_not_member.dart';
import 'package:presentation/ui/fee/current_month_fee/current_month_fee_status/current_month_fee_success.dart';
import 'package:presentation/ui/fee/fee_viewmodel.dart';
import 'package:presentation/ui/fee/skeleton_widget/current_month_fee_skeleton.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';

class CurrentMonthFeeWidget extends StatelessWidget
    with ViewModel<FeeViewModel> {
  const CurrentMonthFeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultFutureBuilder(
      fetchData: read(context).fetchCurrentMonthFee(),
      showOnLoadedWidget: (context, currentMonthFee) {
        return RoundedBorder(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Builder(
            builder: (context) {
              return switch (currentMonthFee.feeStatusType) {
                FeeStatusType.success =>
                  CurrentMonthFeeSuccess(currentMonthFee),
                FeeStatusType.late => CurrentMonthFeeLate(currentMonthFee),
                FeeStatusType.failed => CurrentMonthFeeFailed(currentMonthFee),
                FeeStatusType.notDate => CurrentMonthFeePendingNotDate(),
                FeeStatusType.notMember => CurrentMonthFeePendingNotMember(),
                FeeStatusType.blank => CurrentMonthFeeFailed(currentMonthFee),
              };
            },
          ),
        );
      },
      showOnLoadingWidget: (context) => CurrentMonthFeeSkeleton(),
    );
  }
}
