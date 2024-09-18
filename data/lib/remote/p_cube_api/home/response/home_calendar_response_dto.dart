class HomeCalendarResponseDTO {
  final List<HomeCalendarScheduleDTO> allList;
  final List<HomeCalendarScheduleDTO> upcomingList;

  HomeCalendarResponseDTO({
    required this.allList,
    required this.upcomingList,
  });

  factory HomeCalendarResponseDTO.fromJson(Map<String, dynamic> json) {
    return HomeCalendarResponseDTO(
      allList: (json['all_list'] as List)
          .map<HomeCalendarScheduleDTO>(
              (data) => HomeCalendarScheduleDTO.fromJson(data))
          .toList(),
      upcomingList: (json['upcoming_list'] as List)
          .map<HomeCalendarScheduleDTO>(
              (data) => HomeCalendarScheduleDTO.fromJson(data))
          .toList(),
    );
  }
}

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
