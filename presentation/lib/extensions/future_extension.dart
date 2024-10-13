extension FutureExtension<T> on Future<T> {
  Future<T> getOrDefault(T defaultValue) {
    return catchError((error) => defaultValue);
  }

  Future<T?> getOrNull() {
    return catchError((error) => null);
  }
}
