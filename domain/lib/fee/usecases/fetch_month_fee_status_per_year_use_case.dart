import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/fee/value_object/month_fee_status.dart';
import 'package:get_it/get_it.dart';

class FetchMonthFeeStatusPerYearUseCase {
  final _feeRepository = GetIt.I.get<FeeRepository>();

  Future<List<MonthFeeStatus>> call(int year) async {
    return await _feeRepository.getMonthFeeStatusPerYear(year);
  }
}
