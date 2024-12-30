class AppTimeoutException implements Exception {
  @override
  String toString() => "데이터 로딩 시간이 너무 깁니다.";
}
