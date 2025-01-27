import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:get_it/get_it.dart';

class FetchCurrentMonthFeeUseCase {
  final _feeRepository = GetIt.I.get<FeeRepository>();

  Future<CurrentMonthFee> call() async {
    final now = DateTime.now();
    return await _feeRepository.getCurrentMonthFee(now);
  }
}
