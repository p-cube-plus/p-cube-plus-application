import 'package:data/utils/mock_util.dart';
import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/fee/value_object/account_information.dart';
import 'package:domain/fee/value_object/current_month_fee.dart';
import 'package:domain/fee/value_object/fee_history.dart';
import 'package:domain/fee/value_object/fee_status_type.dart';
import 'package:domain/fee/value_object/month_fee_status.dart';

class MockFeeRepositoryImpl implements FeeRepository {
  var accountInfo = AccountInformation(
    accountBank: "카카오뱅크",
    accountNumber: "1234-5678-90",
    accountOwnerName: "정성희",
  );

  @override
  Future<CurrentMonthFee> getCurrentMonthFee(DateTime now) async {
    await MockUtil().applyMockSetting();
    return CurrentMonthFee(
      feeStatusType: MockUtil().getRandom(FeeStatusType.values),
      feeBeginDate: DateTime.now(),
      feeEndDate: DateTime.now().add(Duration(days: 7)),
      feeAmount: 10000,
    );
  }

  @override
  Future<int> getCurrentTotalFeeAmount() async {
    await MockUtil().applyMockSetting();
    return 1200340;
  }

  @override
  Future<List<FeeHistory>> getFeeHistoryList() async {
    await MockUtil().applyMockSetting();
    return [
      FeeHistory(
        date: DateTime.now().subtract(Duration(days: 30)),
        title: "몰래 엘든링 구매",
        amount: -64800,
      ),
      FeeHistory(
        date: DateTime.now().subtract(Duration(days: 14)),
        title: "회비 정산",
        amount: 950000,
      ),
      FeeHistory(
        date: DateTime.now().subtract(Duration(days: 7)),
        title: "이터널리턴 NP 구매",
        amount: -9900,
      ),
      FeeHistory(
        date: DateTime.now().subtract(Duration(days: 7)),
        title: "이터널리턴 NP 구매",
        amount: -9900,
      ),
      FeeHistory(
        date: DateTime.now().subtract(Duration(days: 7)),
        title: "이터널리턴 NP 구매",
        amount: -9900,
      ),
      FeeHistory(
        date: DateTime.now().add(Duration(days: 14)),
        title: "회비 정산",
        amount: 950000,
      ),
    ];
  }

  @override
  Future<List<MonthFeeStatus>> getMonthFeeStatusPerYear(int year) async {
    await MockUtil().applyMockSetting();
    return List.generate(
      12,
      (index) => MonthFeeStatus(
        month: index + 1,
        feeStatusType: MockUtil().getRandom(FeeStatusType.values),
      ),
    );
  }

  @override
  Future<AccountInformation> getAccountInformation() async {
    await MockUtil().applyMockSetting();
    return accountInfo;
  }

  @override
  Future<void> setAccountInformation(AccountInformation newData) async {
    await MockUtil().applyMockSetting();
    accountInfo = newData;
  }
}
