sealed class InputAuthNumberEvent {}

class InputAuthNumberEventRequestAuthNumber implements InputAuthNumberEvent {}

class InputAuthNumberEventInputAuthNumber implements InputAuthNumberEvent {
  final String text;
  InputAuthNumberEventInputAuthNumber(this.text);
}
