class PhoneNumberTool {
  static bool isPhoneNumber(String string) {
    final RegExp phoneExp =
        RegExp(r'^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$');
    return phoneExp.hasMatch(string);
  }
}
