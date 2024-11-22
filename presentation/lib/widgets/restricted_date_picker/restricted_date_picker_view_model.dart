import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';

class RestrictedDatePickerViewModel extends BaseViewModel<void, void> {
  final Function(DateTime) onDateSelectionComplete;
  final Future<List<int>> Function(DateTime) onRefreshValidDates;

  DateTime currentDate;
  DateTime selectedDay;
  List<int> validDateList = [];

  RestrictedDatePickerViewModel(
    this.selectedDay,
    this.onDateSelectionComplete,
    this.onRefreshValidDates,
  ) : currentDate = selectedDay {
    fetchValidDatesNextMonth();
  }

  void fetchValidDatesNextMonth() {
    validDateList.clear();
    onRefreshValidDates(currentDate).then((value) {
      validDateList = value;
      selectedDay = DateTime(currentDate.year, currentDate.month, value.first);
      notifyListeners();
    });
  }

  void fetchValidDatesPreviousMonth() {
    validDateList.clear();
    onRefreshValidDates(currentDate).then((value) {
      validDateList = value;
      selectedDay = DateTime(currentDate.year, currentDate.month, value.last);
      notifyListeners();
    });
  }

  void moveNextMonth() {
    currentDate = currentDate.nextMonthFirstDate;
    fetchValidDatesNextMonth();
  }

  void movePreviousMonth() {
    currentDate = currentDate.previousMonthFirstDate;
    fetchValidDatesPreviousMonth();
  }

  void moveNextValidDate() {
    final currentIndex =
        validDateList.indexWhere((data) => data == selectedDay.day);

    if (currentIndex == -1) {
      // Not Found Exception
    }

    final nextIndex = currentIndex + 1;
    if (nextIndex < validDateList.length) {
      selectedDay = DateTime(
        selectedDay.year,
        selectedDay.month,
        validDateList[nextIndex],
      );
    } else {
      currentDate = currentDate.nextMonthFirstDate;
      fetchValidDatesNextMonth();
    }
  }

  void movePreviousValidDate() {
    final currentIndex =
        validDateList.indexWhere((data) => data == selectedDay.day);

    if (currentIndex == -1) {
      // Not Found Exception
    }

    final nextIndex = currentIndex + 1;
    if (nextIndex < validDateList.length) {
      selectedDay = DateTime(
        selectedDay.year,
        selectedDay.month,
        validDateList[nextIndex],
      );
    } else {
      currentDate = currentDate.nextMonthFirstDate;
      fetchValidDatesNextMonth();
    }
  }

  bool isValidDay(int day) {
    return validDateList.contains(day);
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
