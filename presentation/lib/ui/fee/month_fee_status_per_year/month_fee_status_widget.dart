import 'package:domain/fee/value_object/fee_status_type.dart';
import 'package:flutter/material.dart';
import 'package:presentation/widgets/status_icon/status_blank.dart';
import 'package:presentation/widgets/status_icon/status_fail.dart';
import 'package:presentation/widgets/status_icon/status_late.dart';
import 'package:presentation/widgets/status_icon/status_pending.dart';
import 'package:presentation/widgets/status_icon/status_success.dart';

class MonthFeeStatusWidget extends StatelessWidget {
  final FeeStatusType feeStatusType;

  const MonthFeeStatusWidget(this.feeStatusType, {super.key});
  @override
  Widget build(BuildContext context) {
    return switch (feeStatusType) {
      FeeStatusType.success => StatusSuccess(size: 32),
      FeeStatusType.late => StatusLate(size: 32),
      FeeStatusType.failed => StatusFail(size: 32),
      FeeStatusType.notDate => StatusPending(size: 32),
      FeeStatusType.notMember => StatusPending(size: 32),
      FeeStatusType.blank => StatusBlank(size: 32),
    };
  }
}
