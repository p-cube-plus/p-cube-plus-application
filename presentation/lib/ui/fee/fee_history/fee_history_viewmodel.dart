import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/fee/usecases/fetch_account_information_use_case.dart';
import 'package:domain/fee/usecases/fetch_current_total_fee_amount_use_case.dart';
import 'package:domain/fee/usecases/fetch_fee_history_use_case.dart';
import 'package:domain/fee/value_object/account_information.dart';
import 'package:domain/fee/value_object/fee_filter_type.dart';
import 'package:domain/fee/value_object/fee_history.dart';
import 'package:presentation/common/base_viewmodel.dart';

class FeeHistoryViewmodel extends BaseViewModel<void> {
  final _fetchFeeHistoryUseCase = FetchFeeHistoryUseCase();
  final _fetchCurrentTotalFeeAmountUseCase =
      FetchCurrentTotalFeeAmountUseCase();
  final _fetchAccountInformationUseCase = FetchAccountInformationUseCase();

  FeeFilterType currentFeeFilterType = FeeFilterType.total;

  List<(DateTime, List<FeeHistory>)>? totalHistory;

  Future<List<(DateTime, List<FeeHistory>)>> fetchFeeHistory() async {
    totalHistory ??= await _fetchFeeHistoryUseCase().getOrDefault([]);

    return switch (currentFeeFilterType) {
      FeeFilterType.total => totalHistory!,
      FeeFilterType.income => totalHistory!
          .map((entry) =>
              (entry.$1, entry.$2.where((fee) => fee.amount > 0).toList()))
          .where((entry) => entry.$2.isNotEmpty)
          .toList(),
      FeeFilterType.outgo => totalHistory!
          .map((entry) =>
              (entry.$1, entry.$2.where((fee) => fee.amount < 0).toList()))
          .where((entry) => entry.$2.isNotEmpty)
          .toList(),
    };
  }

  Future<int> fetchCurrentTotalFeeAmount() =>
      _fetchCurrentTotalFeeAmountUseCase();

  Future<AccountInformation> fetchAccountInformation() =>
      _fetchAccountInformationUseCase();

  void updateFeeFilterType(FeeFilterType newType) {
    currentFeeFilterType = newType;
    notifyListeners();
  }
}
