import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/schedule/usecase/fetch_home_month_schedule_use_case.dart';
import 'package:domain/schedule/usecase/fetch_home_today_schedule_use_case.dart';
import 'package:domain/schedule/value_objects/daily_schedule.dart';
import 'package:domain/schedule/value_objects/month_schedule.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeScheduleViewmodel extends BaseViewModel<void> {
  final _fetchHomeMonthScheduleUseCase = FetchHomeMonthScheduleUseCase();
  final _fetchHomeTodayScheduleUseCase = FetchHomeTodayScheduleUseCase();

  DateTime selectedDate = DateTime.now();

  Future<Map<int, MonthSchedule>> fetchHomeMonthSchedule() =>
      _fetchHomeMonthScheduleUseCase
          .call(
        selectedDate.year,
        selectedDate.month,
      )
          .getOrDefault({});

  Future<List<DailySchedule>> fetchHomeTodaySchedule() =>
      _fetchHomeTodayScheduleUseCase.call(selectedDate).getOrDefault([]);

  void changeCurrentDate(int selectedDay) async {
    selectedDate = selectedDate.copyWith(day: selectedDay);
    notifyListeners();
  }

  void jumpToOneMonthLater() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    notifyListeners();
  }

  void jumpToOneMonthAgo() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
    notifyListeners();
  }
}
