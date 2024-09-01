import 'package:domain/models/home/home_calendar_schedule_data.dart';

class HomeCalendarScheduleDTO {
  final int id;
  final int? type;
  final String title;
  final DateTime startDate;
  final String? startTime;
  final DateTime? endDate;

  HomeCalendarScheduleDTO({
    required this.id,
    required this.type,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.endDate,
  });

  factory HomeCalendarScheduleDTO.fromJson(Map<String, dynamic> json) {
    return HomeCalendarScheduleDTO(
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
}

extension HomeCalendarScheduleDTOExtension on HomeCalendarScheduleDTO {
  HomeCalendarScheduleData toDomain() {
    return HomeCalendarScheduleData(
      id: id,
      type: type,
      title: title,
      startDate: startDate,
      startTime: startTime,
      endDate: endDate,
    );
  }
}
