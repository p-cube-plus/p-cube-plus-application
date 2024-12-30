import 'package:presentation/common/base_viewmodel.dart';

class LoginHomeBottomSheetViewModel extends BaseViewModel<void> {
  bool _isMemberAgreed = false;
  bool get isMemberAgreed => _isMemberAgreed;

  void toggleIsMemberAgreed() {
    _isMemberAgreed = !_isMemberAgreed;
    notifyListeners();
  }
}
