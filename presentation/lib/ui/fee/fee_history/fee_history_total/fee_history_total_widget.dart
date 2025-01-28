import 'package:domain/common/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_viewmodel.dart';
import 'package:presentation/ui/fee/fee_history/skeleton_widget/fee_history_account_text_skeleton.dart';
import 'package:presentation/ui/fee/fee_history/skeleton_widget/fee_history_total_text_skeleton.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class FeeHistoryTotalWidget extends StatelessWidget
    with ViewModel<FeeHistoryViewmodel> {
  const FeeHistoryTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RoundedBorder(
      margin: EdgeInsets.only(top: 24, bottom: 36),
      padding: EdgeInsets.only(top: 32, right: 24, left: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: DefaultFutureBuilder(
              fetchData: read(context).fetchCurrentTotalFeeAmount(),
              showOnLoadedWidget: (context, data) {
                return Text(
                  "${data.toCommaSeparated()}원",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral100,
                  ),
                );
              },
              showOnLoadingWidget: (context) => FeeHistoryTotalTextSkeleton(),
            ),
          ),
          SizedBox(height: 32),
          Divider(
            color: theme.neutral10,
            height: 0,
          ),
          SizedBox(height: 16),
          Text(
            "회비계좌",
            style: TextStyle(
              fontSize: 12,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.neutral80,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${data.accountNumber} ${data.accountOwnerName}",
                      style: TextStyle(
                        fontSize: 14,
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
            showOnLoadingWidget: (context) => FeeHistoryAccountTextSkeleton(),
          )
        ],
      ),
    );
  }

  void _copyAccount(String accountBank, String accountNumber) {
    Clipboard.setData(ClipboardData(text: "$accountBank $accountNumber"));
  }
}
