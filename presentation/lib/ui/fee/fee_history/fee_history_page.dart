import 'package:domain/fee/value_object/fee_filter_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_filter_bottom_sheet/fee_history_filter_bottom_sheet.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_list/fee_history_list_widget.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_total/fee_history_total_widget.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_viewmodel.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_bottomsheet.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:provider/provider.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class FeeHistoryPage extends StatelessWidget {
  const FeeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeeHistoryViewmodel(),
      child: _FeeHistoryPage(),
    );
  }
}

class _FeeHistoryPage extends StatelessWidget
    with ViewModel<FeeHistoryViewmodel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultPage(
      appbar: DefaultAppBar(
        backgroundColor: theme.primary80,
        contentColor: Colors.white,
      ),
      title: "회비 내역",
      backgroundColor: theme.primary80,
      action: GestureDetector(
        onTap: () => _showFilterTypeBottomSheet(context),
        child: Row(
          children: [
            watchWidget((viewModel) => viewModel.currentFeeFilterType,
                (context, currentFeeFilterType) {
              return Text(
                currentFeeFilterType.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral100,
                ),
              );
            }),
            SizedBox(width: 4),
            SvgPicture.asset(
              asset.down,
              colorFilter: ColorFilter.mode(
                theme.neutral100,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
      content: DefaultContent(
        child: Column(
          children: [
            FeeHistoryTotalWidget(),
            FeeHistoryListWidget(),
          ],
        ),
      ),
    );
  }

  void _showFilterTypeBottomSheet(BuildContext context) async {
    final currentFilterType = read(context).currentFeeFilterType;
    final result = await BottomSheetBuilder().build<FeeFilterType>(
        context, FeeHistoryFilterBottomSheet(currentFilterType));

    if (!context.mounted || result == null) return;

    read(context).updateFeeFilterType(result);
  }
}
