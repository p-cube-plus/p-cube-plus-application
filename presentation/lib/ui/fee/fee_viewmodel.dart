import 'package:domain/fee/usecases/fetch_current_month_fee_use_case.dart';
import 'package:domain/fee/usecases/fetch_current_total_fee_amount_use_case.dart';
import 'package:domain/fee/usecases/fetch_month_fee_status_per_year_use_case.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:domain/fee/value_object/month_fee_status.dart';
import 'package:presentation/common/base_viewmodel.dart';

class FeeViewModel extends BaseViewModel<void> {
  final _fetchCurrentMonthFeeUseCase = FetchCurrentMonthFeeUseCase();
  final _fetchMonthFeeStatusPerYearUseCase =
      FetchMonthFeeStatusPerYearUseCase();
  final _fetchCurrentTotalFeeAmountUseCase =
      FetchCurrentTotalFeeAmountUseCase();

  int currentSelectedYear = DateTime.now().year;

  Future<CurrentMonthFee> fetchCurrentMonthFee() =>
      _fetchCurrentMonthFeeUseCase();

  Future<List<MonthFeeStatus>> fetchMonthFeeStatusPerYear() =>
      _fetchMonthFeeStatusPerYearUseCase(currentSelectedYear);

  Future<int> fetchCurrentTotalFeeAmount() =>
      _fetchCurrentTotalFeeAmountUseCase();

  void selectNextYear() {
    ++currentSelectedYear;
  }

  void selectPreviousYear() {
    --currentSelectedYear;
  }
}
