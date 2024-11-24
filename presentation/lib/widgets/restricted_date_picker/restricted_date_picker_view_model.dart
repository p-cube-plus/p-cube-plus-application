import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';

class RestrictedDatePickerViewModel extends BaseViewModel<void, void> {
  final Function(DateTime) onDateSelectionComplete;
  final Future<List<int>> Function(DateTime) _fetchRefreshValidDates;

  DateTime currentDate;
  DateTime? selectedDay;

  RestrictedDatePickerViewModel(
    int targetYear,
    int targetMonth,
    this.onDateSelectionComplete,
    this._fetchRefreshValidDates,
  ) : currentDate = DateTime(targetYear, targetMonth, 1);

  Future<List<int>> fetchRefreshValidDates() =>
      _fetchRefreshValidDates(currentDate);

  void moveNextMonth() {
    currentDate = currentDate.nextMonthFirstDate;
    selectedDay = null;
    notifyListeners();
  }

  void movePreviousMonth() {
    currentDate = currentDate.previousMonthFirstDate;
    selectedDay = null;
    notifyListeners();
  }

  void changeSelectedDay(int newSelectedDay) {
    selectedDay = DateTime(currentDate.year, currentDate.month, newSelectedDay);
    notifyListeners();
  }
}
