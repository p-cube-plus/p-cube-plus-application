import 'package:meta/meta.dart';

@immutable
class FeeHistory {
  final DateTime date;
  final String title;
  final int amount;
  FeeHistory({
    required this.date,
    required this.title,
    required this.amount,
  });
}
