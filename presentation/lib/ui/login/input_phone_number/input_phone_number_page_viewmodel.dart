import 'package:domain/login/usecase/phone_number/fetch_can_click_request_auth_usecase.dart';
import 'package:domain/login/usecase/phone_number/fetch_is_phone_number_max_length.dart';
import 'package:presentation/common/base_viewmodel.dart';

import 'input_phone_number_event.dart';
import 'input_phone_number_state.dart';

class LoginPhoneNumberPageViewModel
    extends BaseViewModel<InputPhoneNumberState, InputPhoneNumberEvent> {
  final fetchCanClickRequestAuth = FetchCanClickRequestAuthUsecase();
  final fetchIsPhoneNumberMaxLength = FetchIsPhoneNumberMaxLengthUsecase();

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
    final canClickRequestAuth = fetchCanClickRequestAuth.call(inputText);
    if (_canClickRequestAuth != canClickRequestAuth) {
      _canClickRequestAuth = canClickRequestAuth;
      notifyListeners();
    }

    final isPhoneNumberMaxLenth = fetchIsPhoneNumberMaxLength.call(inputText);
    if (isPhoneNumberMaxLenth) {
      changeState(InputPhoneNumberState.navigateToAuth);
    }
  }
}
