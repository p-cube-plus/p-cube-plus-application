import 'package:presentation/common/base_viewmodel.dart';

import 'input_phone_number_state.dart';

class LoginPhoneNumberPageViewModel
    extends BaseViewModel<InputPhoneNumberState> {
  bool _canClickRequestAuth = false;
  bool get canClickRequestAuth => _canClickRequestAuth;

  void checkPhoneNumberState(String inputText) {
    final canClickRequestAuth = inputText.length >= ("000-000-0000").length;
    if (_canClickRequestAuth != canClickRequestAuth) {
      _canClickRequestAuth = canClickRequestAuth;
      notifyListeners();
    }

    final isPhoneNumberMaxLenth = inputText.length >= ("000-0000-0000").length;
    if (isPhoneNumberMaxLenth) {
      triggerEvent(InputPhoneNumberState.navigateToAuth);
    }
  }
}
