import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Schedule {
  final int? type;
  final String name;
  final DateTime? startDate, endDate;
  final bool hasSpan;

  Schedule({
    required this.type,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.hasSpan = false,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      type: json['type'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      hasSpan: json['has_span'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'start_date': startDate.toString(),
        'end_date': endDate.toString(),
        'has_span': hasSpan.toString(),
      };
}