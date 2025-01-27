import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/common/extensions/int_extension.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/status_icon/status_fail.dart';

class CurrentMonthFeeFailed extends StatelessWidget {
  const CurrentMonthFeeFailed(this.currentMonthFee, {super.key});

  final CurrentMonthFee currentMonthFee;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        StatusFail(size: 72),
        SizedBox(height: 16),
        Text(
          "아직 회비를 납부하지 않았어요.",
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
        SizedBox(height: 8),
        Divider(
          thickness: 1,
          color: theme.neutral10,
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Text(
            "회비계좌",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: theme.neutral40,
            ),
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () => _copyAccount("카카오뱅크", "123-4556-90 정성희"),
          child: Row(
            children: [
              Text(
                "카카오뱅크",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral80,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "123-4556-90 정성희",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral100,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.content_copy_rounded,
                color: theme.neutral40,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyAccount(String accountBank, String accountNumber) {
    Clipboard.setData(ClipboardData(text: "$accountBank $accountNumber"));
  }
}
