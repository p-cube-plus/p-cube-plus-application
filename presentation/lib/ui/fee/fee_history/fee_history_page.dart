import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_total/fee_history_total_widget.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_viewmodel.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';

class FeeHistoryPage extends StatelessWidget {
  const FeeHistoryPage({super.key, required this.totalAmount});

  final int totalAmount;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeeHistoryViewmodel(),
      child: _FeeHistoryPage(totalAmount),
    );
  }
}

class _FeeHistoryPage extends StatelessWidget
    with ViewModel<FeeHistoryViewmodel> {
  const _FeeHistoryPage(this.totalAmount);

  final int totalAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        leftTitle: "회비 내역",
        backgroundColor: theme.primary80,
        contentColor: Colors.white,
        bottomPadding: 0,
      ),
      content: DefaultContent(
        child: Column(
          children: [
            FeeHistoryTotalWidget(totalAmount),
            SizedBox(height: 36),
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
