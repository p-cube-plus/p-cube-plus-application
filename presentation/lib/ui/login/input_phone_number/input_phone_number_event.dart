sealed class InputPhoneNumberEvent {}

class TextChanged extends InputPhoneNumberEvent {
  final String text;
  TextChanged(this.text);
}
