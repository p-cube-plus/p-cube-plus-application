import 'home_calendar_schedule_dto.dart';

class HomeCalendarDTO {
  final List<HomeCalendarScheduleDTO> allList;
  final List<HomeCalendarScheduleDTO> upcomingList;

  HomeCalendarDTO({
    required this.allList,
    required this.upcomingList,
  });

  factory HomeCalendarDTO.fromJson(Map<String, dynamic> json) {
    return HomeCalendarDTO(
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
