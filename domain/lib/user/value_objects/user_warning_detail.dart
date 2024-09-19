import 'package:domain/member/value_objects/member_warning_type.dart';
import 'package:meta/meta.dart';

@immutable
class UserWarningDetail {
  final String title;
  final MemberWarningType warningType;
  final DateTime warningDate;
  const UserWarningDetail({
    required this.title,
    required this.warningType,
    required this.warningDate,
  });
  // double warningCount;
  // double deductCount;
  // UserWarningDetail({
  //   required this.warningCount,
  //   required this.deductCount,
  // });

  // double get totlaCount {
  //   final result = warningCount - deductCount;
  //   final zeroPointFiveRoundingValue = (result * 2).round() / 2.0;
  //   if (zeroPointFiveRoundingValue < 0) return 0;
  //   return zeroPointFiveRoundingValue;
  // }
}
