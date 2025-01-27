import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/fee/value_object/fee_history.dart';
import 'package:get_it/get_it.dart';

class FetchFeeHistoryUseCase {
  final _feeRepository = GetIt.I.get<FeeRepository>();

  Future<List<(DateTime, List<FeeHistory>)>> call() async {
    final feeHistoryList = await _feeRepository.getFeeHistoryList();

    Map<DateTime, List<FeeHistory>> groupedMap = {};

    for (var feeHistory in feeHistoryList) {
      final dateKey = DateTime(
        feeHistory.date.year,
        feeHistory.date.month,
        feeHistory.date.day,
      );

      if (!groupedMap.containsKey(dateKey)) {
        groupedMap[dateKey] = [];
      }
      groupedMap[dateKey]!.add(feeHistory);
    }

    return groupedMap.entries.map((entry) => (entry.key, entry.value)).toList()
      ..sort((a, b) => b.$1.compareTo(a.$1));
  }
}
