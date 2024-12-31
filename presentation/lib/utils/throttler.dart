class Throttler {
  final Duration duration;
  int? _lastActionTime;
  Future<void>? _ongoingAction;

  Throttler(this.duration);

  void run(Future<void> Function() action) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final msDifference = currentTime - (_lastActionTime ?? 0);

    if (_ongoingAction != null) {
      await _ongoingAction;
    }

    if (msDifference > duration.inMilliseconds) {
      _lastActionTime = currentTime;
      _ongoingAction = action();
      await _ongoingAction;
      _ongoingAction = null;
    }
  }
}
