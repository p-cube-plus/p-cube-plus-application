import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/common/extensions/int_extension.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_viewmodel.dart';
import 'package:presentation/ui/fee/skeleton_widget/current_month_fee_account_skeleton.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/status_icon/status_fail.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class CurrentMonthFeeFailed extends StatelessWidget
    with ViewModel<FeeViewModel> {
  const CurrentMonthFeeFailed(this.currentMonthFee, {super.key});

  final CurrentMonthFee currentMonthFee;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: StatusFail(size: 72)),
        SizedBox(height: 16),
        Center(
          child: Text(
            "아직 회비를 납부하지 않았어요.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.neutral40,
            ),
            textAlign: TextAlign.center,
          ),
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
        Text(
          "회비계좌",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: theme.neutral40,
          ),
        ),
        SizedBox(height: 4),
        DefaultFutureBuilder(
          fetchData: read(context).fetchAccountInformation(),
          showOnLoadedWidget: (context, data) {
            return GestureDetector(
              onTap: () => _copyAccount(data.accountBank, data.accountNumber),
              child: Row(
                children: [
                  Text(
                    data.accountBank,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral80,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${data.accountNumber} ${data.accountOwnerName}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral100,
                    ),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset(
                    asset.copy,
                    colorFilter: ColorFilter.mode(
                      theme.neutral40,
                      BlendMode.srcIn,
                    ),
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            );
          },
          showOnLoadingWidget: (context) => CurrentMonthFeeAccountSkeleton(),
        ),
      ],
    );
  }

  void _copyAccount(String accountBank, String accountNumber) {
    Clipboard.setData(ClipboardData(text: "$accountBank $accountNumber"));
  }
}
