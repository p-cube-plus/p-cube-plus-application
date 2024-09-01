sealed class InputNameEvent {}

class InputNameEventSaveName implements InputNameEvent {
  final String text;
  InputNameEventSaveName(this.text);
}
