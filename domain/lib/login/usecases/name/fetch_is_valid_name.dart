class FetchIsValidName {
  bool call(String inputName) {
    final length = inputName.length;
    return length >= 2 && length <= 4;
  }
}
