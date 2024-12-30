import 'package:domain/schedule/usecase/fetch_home_month_schedule_use_case.dart';
import 'package:domain/schedule/usecase/fetch_home_today_schedule_use_case.dart';
import 'package:domain/schedule/value_objects/daily_schedule.dart';
import 'package:domain/schedule/value_objects/month_schedule.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeScheduleViewmodel extends BaseViewModel<void> {
  final _fetchHomeMonthScheduleUseCase = FetchHomeMonthScheduleUseCase();
  final _fetchHomeTodayScheduleUseCase = FetchHomeTodayScheduleUseCase();

  Map<int, MonthSchedule> monthSchedule = {};
  List<DailySchedule> todayScheduleList = [];
  DateTime selectedDate = DateTime.now();

  HomeScheduleViewmodel() {
    _fetchHomeSchedule();
  }

  void changeCurrentDate(int selectedDay) async {
    selectedDate = selectedDate.copyWith(day: selectedDay);
    notifyListeners();
    todayScheduleList = await _fetchHomeTodayScheduleUseCase.call(selectedDate);
    notifyListeners();
  }

  void jumpToOneMonthLater() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    notifyListeners();
    _fetchHomeSchedule();
  }

  void jumpToOneMonthAgo() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
    notifyListeners();
    _fetchHomeSchedule();
  }

  void _fetchHomeSchedule() async {
    monthSchedule = await _fetchHomeMonthScheduleUseCase.call(
      selectedDate.year,
      selectedDate.month,
    );
    todayScheduleList = await _fetchHomeTodayScheduleUseCase.call(selectedDate);
    notifyListeners();
  }
}
