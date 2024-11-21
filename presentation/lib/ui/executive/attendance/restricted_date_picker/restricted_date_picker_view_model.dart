import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';

class RestrictedDatePickerViewModel extends BaseViewModel<void, void> {
  final Function(DateTime) onDateSelectionComplete;
  final Set<int> Function(DateTime) onRefreshValidDates;

  DateTime currentDate = DateTime.now();
  DateTime selectedDay = DateTime.now();
  Set<int> _validDaySet = {3, 10, 17, 24};
  bool isInitialize = false;

  RestrictedDatePickerViewModel(
    this.onDateSelectionComplete,
    this.onRefreshValidDates,
  ) {
    selectedDay =
        DateTime(currentDate.year, currentDate.month, _validDaySet.first);
  }

  void moveNextMonth() {
    currentDate = currentDate.nextMonthFirstDate;
    selectedDay =
        DateTime(currentDate.year, currentDate.month, _validDaySet.first);
    notifyListeners();
  }

  void movePreviousMonth() {
    currentDate = currentDate.previousMonthFirstDate;
    selectedDay =
        DateTime(currentDate.year, currentDate.month, _validDaySet.last);
    notifyListeners();
  }

  bool isValidDay(int day) {
    return _validDaySet.contains(day);
  }

  void changeSelectedDay(int newDay) {
    selectedDay = DateTime(selectedDay.year, selectedDay.month, newDay);
    notifyListeners();
  }

  Function? onDateSelect() {
    if (isInitialize) return null;
    return onDateSelectionComplete(selectedDay);
  }
}
