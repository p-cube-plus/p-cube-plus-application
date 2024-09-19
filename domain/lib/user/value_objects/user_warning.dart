import 'package:meta/meta.dart';

@immutable
class UserWarning {
  final double cumulativeWarningCount;
  const UserWarning({
    required this.cumulativeWarningCount,
  });
}
