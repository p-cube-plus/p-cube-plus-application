import 'package:meta/meta.dart';

@immutable
class UserProjectDetail {
  final String title;
  final String type;
  final DateTime startDate;
  final DateTime? endDate;
  final int memberCount;
  const UserProjectDetail({
    required this.title,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.memberCount,
  });
}
