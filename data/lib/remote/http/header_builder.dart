import 'token_holder.dart';

class HeaderBuilder {
  final Map<String, String> _headers = {};
  final tokenHolder = TokenHolder();
  Map<String, String> build() => _headers;

  HeaderBuilder contentTypeJson() {
    _headers["Content-Type"] = "application/json";
    return this;
  }

  HeaderBuilder withToken() {
    _headers["Authorization"] = tokenHolder.accessToken;
    return this;
  }

  HeaderBuilder withRefreshToken() {
    _headers["Authorization"] = tokenHolder.refreshToken;
    return this;
  }

  HeaderBuilder withCookie(String? cookie) {
    _headers["cookie"] = cookie ?? "";
    return this;
  }
}
