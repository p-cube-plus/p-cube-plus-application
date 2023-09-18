import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Attendance {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime? endDate;

  Attendance({
    required this.id,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.endDate,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      startTime: DateTime.parse(json['start_time']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'start_date': startDate.toString(),
        'start_time': startTime.toString(),
        'end_date': endDate.toString(),
      };
}
