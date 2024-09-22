import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/schedule_detail.dart';
import 'package:get_it/get_it.dart';

class FetchHomeTodayScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<List<ScheduleDetail>> call(DateTime selectedDate) {
    return _scheduleRepository.getDailyScheduleDetailList(selectedDate);
  }
}
