import 'package:domain/fee/value_object/fee_status_type.dart';
import 'package:meta/meta.dart';

@immutable
class CurrentMonthFee {
  final FeeStatusType feeStatusType;
  final DateTime feeBeginDate;
  final DateTime feeEndDate;
  final int feeAmount;
  CurrentMonthFee({
    required this.feeStatusType,
    required this.feeBeginDate,
    required this.feeEndDate,
    required this.feeAmount,
  });
}
