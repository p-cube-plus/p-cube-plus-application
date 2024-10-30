class Debouncer {
  final Duration duration;
  void Function()? _action;
  bool _isWaiting = false;

  Debouncer(this.duration);

  void run(void Function() action) {
    _action = action;

    if (_isWaiting) {
      return;
    }
    _isWaiting = true;

    Future.delayed(duration, () {
      _action?.call();
      _isWaiting = false;
      _action = null;
    });
  }
}
