import 'package:domain/fee/value_object/account_information.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:domain/fee/value_object/fee_history.dart';
import 'package:domain/fee/value_object/month_fee_status.dart';

abstract interface class FeeRepository {
  Future<CurrentMonthFee> getCurrentMonthFee(DateTime now);
  Future<List<MonthFeeStatus>> getMonthFeeStatusPerYear(int year);
  Future<int> getCurrentTotalFeeAmount();
  Future<List<FeeHistory>> getFeeHistoryList();
  Future<AccountInformation> getAccountInformation();
  Future<void> setAccountInformation(AccountInformation newData);
}
