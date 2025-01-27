import 'package:domain/fee/value_object/fee_status_type.dart';
import 'package:meta/meta.dart';

@immutable
class MonthFeeStatus {
  final int month;
  final FeeStatusType feeStatusType;
  const MonthFeeStatus({
    required this.month,
    required this.feeStatusType,
  });
}
