import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/current_month_fee/current_month_fee.dart';
import 'package:presentation/ui/fee/fee_viewmodel.dart';
import 'package:presentation/ui/fee/month_fee_status_per_year/month_fee_status_per_year_widget.dart';
import 'package:presentation/ui/fee/total_fee/total_fee_widget.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class FeePage extends StatelessWidget {
  const FeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeeViewModel(),
      child: _FeePage(),
    );
  }
}

class _FeePage extends StatelessWidget with ViewModel<FeeViewModel> {
  const _FeePage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      title: "회비",
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "이번 달 회비 납부",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 8),
            CurrentMonthFeeWidget(),
            SizedBox(height: 40),
            Text(
              "연도별 회비 납부",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 8),
            MonthFeeStatusPerYearWidget(),
            SizedBox(height: 40),
            Text(
              "회비 내역",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.neutral100,
              ),
            ),
            SizedBox(height: 8),
            TotalFeeWidget(),
          ],
        ),
      ),
    );
  }
}
