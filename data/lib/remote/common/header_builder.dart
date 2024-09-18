class HeaderBuilder {
  final Map<String, String> _headers = {};
  Map<String, String> build() => _headers;

  HeaderBuilder contentTypeJson() {
    _headers["Content-Type"] = "application/json";
    return this;
  }

  HeaderBuilder withToken(String token) {
    _headers["Authorization"] = token;
    return this;
  }

  HeaderBuilder withCookie(String? cookie) {
    _headers["cookie"] = cookie ?? "";
    return this;
  }
}
