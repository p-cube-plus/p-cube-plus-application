import 'package:domain/user/value_objects/user_warning_content.dart';
import 'package:meta/meta.dart';

@immutable
class UserWarningDetail {
  final List<UserWarningContent> warningHistory;
  final List<UserWarningContent> warningReductionHistory;

  UserWarningDetail({
    required this.warningHistory,
    required this.warningReductionHistory,
  });

  late final double warningCount = warningHistory
      .map((value) => value.warningPoint)
      .fold(0.0, (sum, element) {
    return sum + element;
  });

  late final double warningReductionCount = warningReductionHistory
      .map((value) => value.warningPoint)
      .fold(0.0, (sum, element) {
    return sum - element;
  });

  late final double totlaCount =
      (warningCount - warningReductionCount).clamp(0.0, double.infinity);
}
