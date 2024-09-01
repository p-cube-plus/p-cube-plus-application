class Throttler {
  final Duration duration;
  int? _lastActionTime;

  Throttler(this.duration);

  void run(void Function() action) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final msDifference = currentTime - (_lastActionTime ?? 0);
    if (msDifference > duration.inMilliseconds) {
      action();
      _lastActionTime = currentTime;
    }
  }
}
