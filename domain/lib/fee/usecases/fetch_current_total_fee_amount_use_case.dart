import 'package:domain/fee/repository/fee_repository.dart';
import 'package:get_it/get_it.dart';

class FetchCurrentTotalFeeAmountUseCase {
  final _feeRepository = GetIt.I.get<FeeRepository>();

  Future<int> call() async {
    return await _feeRepository.getCurrentTotalFeeAmount();
  }
}
