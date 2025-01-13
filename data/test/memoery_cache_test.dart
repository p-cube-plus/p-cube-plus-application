import 'dart:developer';

import 'package:data/common/memory_cache.dart';
import 'package:test/test.dart';
import 'dart:async';

// flutter test test/memoery_cache_test.dart
void main() {
  group('MemoryCache 테스트:', () {
    test('일반 비동기가 연속적으로 불릴 때', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value1 = await _isCachedValue(cache);
      final value2 = await _isCachedValue(cache);
      final value3 = await _isCachedValue(cache);
      expect(!value1 && value2 && value3 && cache.completerLength == 0, true);
    });
    test('Future.value가 연속적으로 불릴 때', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value1 = await Future.value(_isCachedValue(cache));
      final value2 = await Future.value(_isCachedValue(cache));
      final value3 = await Future.value(_isCachedValue(cache));
      expect(!value1 && value2 && value3 && cache.completerLength == 0, true);
    });
    test('Future.microtask가 연속적으로 불릴 때', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value1 = await Future.microtask(() => _isCachedValue(cache));
      final value2 = await Future.microtask(() => _isCachedValue(cache));
      final value3 = await Future.microtask(() => _isCachedValue(cache));
      expect(!value1 && value2 && value3 && cache.completerLength == 0, true);
    });
    test('Future.sync가 연속적으로 불릴 때', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value1 = await Future.sync(() => _isCachedValue(cache));
      final value2 = await Future.sync(() => _isCachedValue(cache));
      final value3 = await Future.sync(() => _isCachedValue(cache));
      expect(!value1 && value2 && value3 && cache.completerLength == 0, true);
    });
    test('Future.wait가 불릴 때', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value = await Future.wait([
        _isCachedValue(cache),
        _isCachedValue(cache),
        _isCachedValue(cache),
      ]);
      final value2 = await Future.wait([
        _isCachedValue(cache),
        _isCachedValue(cache),
      ]);
      final value3 = await Future.wait([
        _isCachedValue(cache),
        _isCachedValue(cache),
      ]);
      expect(
          !value[0] &&
              value[1] &&
              value[2] &&
              value2[0] &&
              value2[1] &&
              value3[0] &&
              value3[1] &&
              cache.completerLength == 0,
          true);
    });
    test('재캐싱 테스트', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value1 = await _isCachedValue(cache);
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value2 = await _isCachedValue(cache);
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value3 = await _isCachedValue(cache);
      expect(!value1 && !value2 && !value3 && cache.completerLength == 0, true);
    });
    test('강제 업데이트 테스트', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 2));
      final value1 = await _isCachedValue(cache);
      await Future.delayed(Duration(seconds: 1));
      final value2 = await _isCachedValue(cache);
      final value3 = await _isCachedValue(cache, isForcedUpdate: true);
      expect(!value1 && value2 && !value3 && cache.completerLength == 0, true);
    });
    test('통합 테스트', () async {
      final cache = MemoryCache<CacheTest>(Duration(seconds: 1));
      final value1 = await _isCachedValue(cache);
      final value2 = await _isCachedValue(cache);
      final value3 = await _isCachedValue(cache);
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value4 = await Future.value(_isCachedValue(cache));
      final value5 = await Future.value(_isCachedValue(cache));
      final value6 = await Future.value(_isCachedValue(cache));
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value7 = await Future.microtask(() => _isCachedValue(cache));
      final value8 = await Future.microtask(() => _isCachedValue(cache));
      final value9 = await Future.microtask(() => _isCachedValue(cache));
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value10 = await Future.sync(() => _isCachedValue(cache));
      final value11 = await Future.sync(() => _isCachedValue(cache));
      final value12 = await Future.sync(() => _isCachedValue(cache));
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value13 = await Future.wait([
        _isCachedValue(cache),
        _isCachedValue(cache),
        _isCachedValue(cache),
      ]);
      await Future.delayed(Duration(seconds: 1, milliseconds: 1));
      final value14 = await _isCachedValue(cache);
      final value15 = await _isCachedValue(cache, isForcedUpdate: true);
      final value16 = await Future.value(_isCachedValue(cache));
      final value17 = await Future.microtask(() => _isCachedValue(cache));
      final value18 = await Future.sync(() => _isCachedValue(cache));
      final value19 = await Future.wait([
        _isCachedValue(cache),
        _isCachedValue(cache),
      ]);
      expect(
        !value1 &&
            value2 &&
            value3 &&
            !value4 &&
            value5 &&
            value6 &&
            !value7 &&
            value8 &&
            value9 &&
            !value10 &&
            value11 &&
            value12 &&
            !value13[0] &&
            value13[1] &&
            value13[2] &&
            !value14 &&
            !value15 &&
            value16 &&
            value17 &&
            value18 &&
            value19[0] &&
            value19[1] &&
            cache.completerLength == 0,
        true,
      );
    });
  });
}

class CacheTest {
  final int value;
  CacheTest(this.value);
}

Future<bool> _isCachedValue(
  MemoryCache<CacheTest> cache, {
  bool isForcedUpdate = false,
}) async {
  var result = true;
  await cache.fetchOrCache(
    () async {
      result = false;
      return CacheTest(1);
    },
    isForcedUpdate: isForcedUpdate,
  );

  if (result) {
    log("cache 데이터 반환");
  } else {
    log("fetch 데이터 반환");
  }
  return result;
}
