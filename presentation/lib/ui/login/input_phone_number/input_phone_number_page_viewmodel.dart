import 'package:presentation/common/base_viewmodel.dart';

import 'input_phone_number_event.dart';
import 'input_phone_number_state.dart';

class LoginPhoneNumberPageViewModel
    extends BaseViewModel<InputPhoneNumberState, InputPhoneNumberEvent> {
  bool _canClickRequestAuth = false;
  bool get canClickRequestAuth => _canClickRequestAuth;

  LoginPhoneNumberPageViewModel() {
    _setEventListener();
  }

  void _setEventListener() {
    userActionEventStream.listen((event) {
      switch (event) {
        case TextChanged(:final text):
          checkPhoneNumberState(text);
      }
    });
  }

  void checkPhoneNumberState(String inputText) {
    final canClickRequestAuth = inputText.length >= ("000-000-0000").length;
    if (_canClickRequestAuth != canClickRequestAuth) {
      _canClickRequestAuth = canClickRequestAuth;
      notifyListeners();
    }

    final isPhoneNumberMaxLenth = inputText.length >= ("000-0000-0000").length;
    if (isPhoneNumberMaxLenth) {
      changeState(InputPhoneNumberState.navigateToAuth);
    }
  }
}
