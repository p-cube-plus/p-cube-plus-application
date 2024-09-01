extension FutureExtension<T> on Future<T> {
  Future<T> getOrDefault(T defaultValue) {
    return then((value) => value).catchError((error) => defaultValue);
  }

  Future<T?> getOrNull() {
    return then<T?>((value) => value).catchError((error) => null);
  }

  /// 실패해도 아무 지장없는 비동기 작업에만 사용할 것.
  /// ex) 캐시 데이터 로드 실패
  Future<T> ignoreException() {
    return catchError((_) {});
  }
}
