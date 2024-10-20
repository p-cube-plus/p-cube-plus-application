import 'package:presentation/common/base_viewmodel.dart';

import 'input_name_event.dart';

class LoginNamePageViewModel extends BaseViewModel<void, InputNameEvent> {
  bool isNameAvailable = false;
  String _name = "";
  String get name => _name;

  final String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  LoginNamePageViewModel(String phoneNumber) : _phoneNumber = phoneNumber {
    _setEventListener();
  }

  void _setEventListener() {
    uiEventStream.listen((event) {
      switch (event) {
        case InputNameEventSaveName(:final text):
          _saveName(text);
      }
    });
  }

  void _saveName(String inputName) {
    _name = inputName;
    if (inputName.length >= 2) {
      isNameAvailable = true;
    } else {
      isNameAvailable = false;
    }
    notifyListeners();
  }
}
