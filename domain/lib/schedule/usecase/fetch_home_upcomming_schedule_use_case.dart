import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:get_it/get_it.dart';

class FetchHomeUpcommingScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<List<ScheduleData>> call() {
    return _scheduleRepository.getUpcommingScheduleDetailList();
  }
}
