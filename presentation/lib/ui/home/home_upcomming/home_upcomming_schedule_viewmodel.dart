import 'package:domain/schedule/usecase/fetch_home_upcomming_schedule_use_case.dart';
import 'package:domain/schedule/value_objects/schedule_detail.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeUpcommingScheduleViewModel extends BaseViewModel<void, void> {
  final _fetchHomeUpcommingScheduleUseCase =
      FetchHomeUpcommingScheduleUseCase();

  Future<List<ScheduleDetail>> fetchData() {
    return _fetchHomeUpcommingScheduleUseCase.call();
  }
}
