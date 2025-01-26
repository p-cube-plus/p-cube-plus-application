import 'package:domain/common/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_page.dart';
import 'package:presentation/ui/fee/fee_viewmodel.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';

class TotalFeeWidget extends StatelessWidget with ViewModel<FeeViewModel> {
  const TotalFeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultFutureBuilder(
      fetchData: read(context).fetchCurrentTotalFeeAmount(),
      showOnLoadedWidget: (context, currentTotalFeeAmount) {
        return RoundedBorder(
          padding: EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
          onTap: () =>
              _navigateToFeeHistoryPage(context, currentTotalFeeAmount),
          child: Row(
            children: [
              Text(
                "${currentTotalFeeAmount.toCommaSeparated()}원",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral100,
                ),
              ),
              Expanded(
                child: Text(
                  "자세히 보기",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.neutral40,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Icon(
                Icons.navigate_next_rounded,
                size: 24,
                color: theme.neutral40,
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToFeeHistoryPage(BuildContext context, int totalFeeAmount) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FeeHistoryPage(totalAmount: totalFeeAmount),
      ),
    );
  }
}
