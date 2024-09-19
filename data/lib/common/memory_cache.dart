import 'dart:async';

/// 데이터 레이어의 핵심 캐싱 클래스
/// 수정 시 테스트 코드 검증 필수
/// flutter test test/memoery_cache_test.dart
class MemoryCache<T> {
  final Duration _duration;
  int? _lastCachedTime;
  T? _data;

  // Future.wait 비동기 동시성 문제 처리
  final List<Completer<void>?> _completers = [];
  int get completerLength => _completers.length;

  MemoryCache(this._duration);

  FutureOr<T?> fetchOrCache(Future<T> Function() fetchData) async {
    var currentLength = 0;
    await Future.sync(() {
      currentLength = _completers.length;
      _completers.add(Completer<void>());
    });

    if (currentLength > 0) {
      await _completers[currentLength - 1]?.future;
    }

    if (_isCacheExpired()) {
      _data = await fetchData();
      _lastCachedTime = DateTime.now().millisecondsSinceEpoch;
    }

    _completers[currentLength]?.complete();
    _completers[currentLength] = null;
    for (var completer in _completers) {
      if (completer != null) {
        return _data;
      }
    }

    _completers.clear();
    return _data;
  }

  bool _isCacheExpired() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final msDifference = currentTime - (_lastCachedTime ?? 0);
    return msDifference > _duration.inMilliseconds;
  }
}
