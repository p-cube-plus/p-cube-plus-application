extension FutureExtension<T> on Future<T> {
  Future<T> getOrDefault(T defaultValue) {
    return catchError((error) => defaultValue);
  }

  Future<T?> getOrNull() async {
    try {
      return await this;
    } catch (_) {
      return null;
    }
  }

  Future<T> getOrThrow() {
    return catchError((error) => throw error);
  }
}
