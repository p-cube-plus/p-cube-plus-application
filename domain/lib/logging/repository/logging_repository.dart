abstract interface class LoggingRepository {
  Future<void> logEvent(
    String eventName,
    Map<String, Object>? parameters,
  );
}
