import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/common/extensions/int_extension.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/status_icon/status_success.dart';

class CurrentMonthFeeSuccess extends StatelessWidget {
  const CurrentMonthFeeSuccess(this.currentMonthFee, {super.key});

  final CurrentMonthFee currentMonthFee;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        StatusSuccess(size: 72),
        SizedBox(height: 16),
        Text(
          "회비 납부 완료!",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "납부 기간",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: theme.neutral80,
              ),
            ),
            Text(
              "${currentMonthFee.feeBeginDate.format("M월 d일")} ~ ${currentMonthFee.feeEndDate.format("M월 d일")}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.neutral80,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "납부 금액",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: theme.neutral80,
              ),
            ),
            Text(
              "${currentMonthFee.feeAmount.toCommaSeparated()}원",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.neutral80,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
