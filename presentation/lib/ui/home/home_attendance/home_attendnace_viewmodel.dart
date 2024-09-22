import 'package:domain/attendance/usecases/fetch_home_attendance_use_case.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeAttendnaceViewModel extends BaseViewModel<void, void> {
  final _fetchHomeAttendanceUseCase = FetchHomeAttendanceUseCase();

  Future<List<HomeAttendance>> fetchData() async {
    return _fetchHomeAttendanceUseCase.call();
  }
}
