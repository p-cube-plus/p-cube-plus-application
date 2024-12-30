import 'package:presentation/common/base_viewmodel.dart';

class LoginNamePageViewModel extends BaseViewModel<void> {
  bool isNameAvailable = false;
  String _name = "";
  String get name => _name;

  final String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  LoginNamePageViewModel(String phoneNumber) : _phoneNumber = phoneNumber;

  void saveName(String inputName) {
    _name = inputName;
    if (inputName.length >= 2) {
      isNameAvailable = true;
    } else {
      isNameAvailable = false;
    }
    notifyListeners();
  }
}
