import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/schedule_detail.dart';
import 'package:get_it/get_it.dart';

class FetchHomeUpcommingScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<List<ScheduleDetail>> call() {
    return _scheduleRepository.getUpcommingScheduleDetailList();
  }
}
