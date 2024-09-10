import 'dart:async';

class MemoryCache<T> {
  FutureOr<T?> Function() fetchData;

  Duration? duration;
  int? _lastCachedTime;
  T? data;
  bool isFirstCache = true;

  MemoryCache(this.fetchData, {this.duration});

  FutureOr<T?> get({bool isForcedUpdate = false}) async {
    if (isForcedUpdate) {
      isFirstCache = false;
      return fetchData();
    }

    if (duration == null && !isFirstCache) {
      data ??= await fetchData();
      return data;
    }

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final msDifference = currentTime - (_lastCachedTime ?? 0);
    if (msDifference > duration!.inMilliseconds) {
      data = await fetchData();
      _lastCachedTime = DateTime.now().millisecondsSinceEpoch;
      return data;
    }

    return data;
  }
}
