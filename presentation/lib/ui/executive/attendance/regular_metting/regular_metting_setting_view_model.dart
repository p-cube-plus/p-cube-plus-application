import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/attendance/regular_metting/regular_metting_setting_event.dart';

class RegularMettingSettingViewModel
    extends BaseViewModel<RegularMettingSettingEvent, void> {
  bool isVisibleTopWidget = true;

  void toggleTopWidgetVisible() {
    isVisibleTopWidget = !isVisibleTopWidget;
    notifyListeners();
  }
}
