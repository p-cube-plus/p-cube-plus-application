import 'package:presentation/common/base_viewmodel.dart';

import 'login_home_bottomsheet_event.dart';

class LoginHomeBottomSheetViewModel
    extends BaseViewModel<void, LoginHomeBottomSheetEvent> {
  bool _isMemberAgreed = false;
  bool get isMemberAgreed => _isMemberAgreed;

  LoginHomeBottomSheetViewModel() {
    setEventListener();
  }

  void setEventListener() {
    uiEventStream.listen((event) {
      switch (event) {
        case LoginHomeBottomSheetEvent.onClickMemberAgree:
          _toggleIsMemberAgreed();
      }
    });
  }

  void _toggleIsMemberAgreed() {
    _isMemberAgreed = !_isMemberAgreed;
    notifyListeners();
  }
}
