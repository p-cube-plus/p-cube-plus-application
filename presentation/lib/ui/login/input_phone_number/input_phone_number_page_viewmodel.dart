import 'package:presentation/common/base_viewmodel.dart';

import 'input_phone_number_event.dart';
import 'input_phone_number_state.dart';

class LoginPhoneNumberPageViewModel
    extends BaseViewModel<InputPhoneNumberState, InputPhoneNumberEvent> {
  String phoneNumber = "";
  bool canClickRequestAuth = false;

  LoginPhoneNumberPageViewModel() {
    _setEventListener();
  }

  void _setEventListener() {
    eventStream.listen((event) {
      switch (event) {
        case TextChanged(:final text):
          savePhoneNumber(text);
      }
    });
  }

  void savePhoneNumber(String inputText) {
    phoneNumber = inputText;

    final length = _getPhoneNumberLength(inputText);
    canClickRequestAuth = length >= 10;
    notifyListeners();

    final isPhoneNumberMaxLenth = length == 11;
    if (isPhoneNumberMaxLenth) {
      changeState(InputPhoneNumberState.navigateToAuth);
    }
  }

  int _getPhoneNumberLength(String phoneNumber) {
    var rawPhoneNumber = phoneNumber.replaceAll("-", "");
    return rawPhoneNumber.length;
  }
}
