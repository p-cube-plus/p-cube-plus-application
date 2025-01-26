import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/fee/value_object/fee_history.dart';
import 'package:get_it/get_it.dart';

class FetchFeeHistoryUseCase {
  final _feeRepository = GetIt.I.get<FeeRepository>();

  Future<List<FeeHistory>> call() async {
    return await _feeRepository.getFeeHistoryList();
  }
}
