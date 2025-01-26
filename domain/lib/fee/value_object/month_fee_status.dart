import 'package:domain/fee/value_object/fee_status_type.dart';

@immutable
class MonthFeeStatus {
  final int month;
  final FeeStatusType feeStatusType;
  MonthFeeStatus({
    required this.month,
    required this.feeStatusType,
  });
}
