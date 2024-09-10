import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/constants/asset_path.dart' as asset_path;

import 'login_home_bottomsheet_event.dart';

class LoginHomeBottomSheetViewModel
    extends BaseViewModel<void, LoginHomeBottomSheetEvent> {
  bool _isMemberAgreed = false;
  bool get isMemberAgreed => _isMemberAgreed;

  String get memberAgreedImagePath => _isMemberAgreed
      ? asset_path.checkCircleSelected
      : asset_path.checkCircleUnselected;

  LoginHomeBottomSheetViewModel() {
    setEventListener();
  }

  void setEventListener() {
    userActionEventStream.listen((event) {
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
