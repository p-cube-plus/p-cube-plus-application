class Debouncer {
  final Duration duration;
  int? _lastActionTime;
  void Function()? _action;
  bool _isWaiting = false;

  Debouncer(this.duration);

  void run(void Function() action) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (_isWaiting) {
      _action = action;
      return;
    }

    _action = action;
    _isWaiting = true;

    Future.delayed(duration, () {
      _action?.call();
      _lastActionTime = currentTime;
      _isWaiting = false;
      _action = null;
    });
  }
}
