extension FutureExtension<T> on Future<T> {
  Future<T> getOrDefault(T defaultValue) async {
    try {
      return await this;
    } catch (_) {
      return defaultValue;
    }
  }

  Future<T?> getOrNull() async {
    try {
      return await this;
    } catch (_) {
      return null;
    }
  }

  Future<T> getOrThrow() async {
    try {
      return await this;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> onFailure(
      void Function(Object error) errorHandleFunction) async {
    try {
      await this;
    } catch (error) {
      errorHandleFunction(error);
    }
  }
}
