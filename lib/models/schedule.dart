import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

@JsonSerializable()
class Schedule {
  final int id;
  final int? type;
  final String title;
  final DateTime startDate;
  final String? startTime;
  final DateTime? endDate;

  Color getMarkColor() {
    return [
      Color(0xCCDE2B13),
      Color(0xFF5EDCA7),
      Color(0xCC4813DE)
    ][type == null ? 0 : type!];
  }

  Schedule({
    required this.id,
    required this.type,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.endDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      startTime: json['start_time'],
      endDate: json['end_date'] == null
          ? DateTime.parse(json['start_date'])
          : DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'start_date': startDate.toString(),
        'start_time': startTime,
        'end_date': endDate.toString(),
      };
}
