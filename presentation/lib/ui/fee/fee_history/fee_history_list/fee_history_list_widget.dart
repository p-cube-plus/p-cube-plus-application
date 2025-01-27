import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/common/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/fee/fee_history/fee_history_viewmodel.dart';
import 'package:presentation/ui/fee/fee_history/skeleton_widget/fee_history_list_skeleton.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/rounded_border.dart';

class FeeHistoryListWidget extends StatelessWidget
    with ViewModel<FeeHistoryViewmodel> {
  const FeeHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return watchWidget((viewModel) => viewModel.currentFeeFilterType,
        (context, currentFeeFilterType) {
      return DefaultFutureBuilder(
        fetchData: read(context).fetchFeeHistory(),
        showOnLoadedWidget: (context, data) {
          return Column(
            children: List.generate(data.length, (index) {
              final (date, historyList) = data[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date.format("M월 d일"),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.neutral60,
                    ),
                  ),
                  RoundedBorder(
                    margin: EdgeInsets.only(top: 4, bottom: 24),
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: List.generate(historyList.length, (index) {
                        final history = historyList[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  history.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: theme.neutral100,
                                  ),
                                ),
                              ),
                              Text(
                                "${history.amount.toCommaSeparated()}원",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: theme.neutral100,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          );
        },
        showOnLoadingWidget: (context) => FeeHistoryListSkeleton(),
      );
    });
  }
}
