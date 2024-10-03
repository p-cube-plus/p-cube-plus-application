import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/daily_schedule.dart';
import 'package:get_it/get_it.dart';

class FetchHomeTodayScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<List<DailySchedule>> call(DateTime selectedDate) async {
    final scheduleList =
        await _scheduleRepository.getDailyScheduleDetailList(selectedDate);
    List<DailySchedule> result = [];

    for (var schedule in scheduleList) {
      if (schedule.startDate.day == selectedDate.day) {
        result.add(schedule.toStartDailySchedule());
      }
      if (schedule.endDate.day == selectedDate.day) {
        result.add(schedule.toEndDailySchedule());
      }

      if (schedule.startDate.day != selectedDate.day &&
          schedule.endDate.day != selectedDate.day) {
        result.add(schedule.toOngoingDailySchedule(selectedDate));
      }
    }
    result.sort((a, b) => a.scheduleDate.hour.compareTo(b.scheduleDate.hour));
    return result;
  }
}
