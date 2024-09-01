import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formattedText;
    
    if (digitsOnly.length <= 3) {
      formattedText = digitsOnly;
    } else if (digitsOnly.length <= 6) {
      formattedText = digitsOnly.replaceFirstMapped(
          RegExp(r'(\d{3})(\d+)'), (Match m) => '${m[1]}-${m[2]}');
    } else if (digitsOnly.length <= 10) {
      formattedText = digitsOnly.replaceFirstMapped(
          RegExp(r'(\d{3})(\d{3})(\d+)'),
          (Match m) => '${m[1]}-${m[2]}-${m[3]}');
    } else {
      formattedText = digitsOnly.replaceFirstMapped(
          RegExp(r'(\d{3})(\d{4})(\d+)'),
          (Match m) => '${m[1]}-${m[2]}-${m[3]}');
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
