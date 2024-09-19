import 'package:color/color.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:meta/meta.dart';

@immutable
class ScheduleData {
  final ScheduleType type;
  final String title;
  final DateTime startDate;
  final DateTime endDate;

  const ScheduleData({
    required this.type,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  Color get markColor {
    return [
      Color.hex("DE2B13"),
      Color.hex("5EDCA7"),
      Color.hex("4813DE"),
    ][type.index];
  }
}
