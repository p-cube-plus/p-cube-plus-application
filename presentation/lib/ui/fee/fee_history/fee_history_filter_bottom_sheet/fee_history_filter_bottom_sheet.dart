import 'package:domain/fee/value_object/fee_filter_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_radio_group_tile.dart';

class FeeHistoryFilterBottomSheet extends StatelessWidget {
  final FeeFilterType initFilterType;

  const FeeHistoryFilterBottomSheet(this.initFilterType, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "내역 유형",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        SizedBox(height: 16),
        DefaultRadioGroupTile<FeeFilterType>(
          onTap: (data) {
            Navigator.of(context).pop(data);
          },
          radioDataList: [
            RadioData(title: "전체", data: FeeFilterType.total),
            RadioData(title: "입금", data: FeeFilterType.income),
            RadioData(title: "출금", data: FeeFilterType.outgo),
          ],
          initializeIndex: initFilterType.index,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
