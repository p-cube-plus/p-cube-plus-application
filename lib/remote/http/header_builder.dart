import 'package:p_cube_plus_application/remote/utils/token_manager.dart';

class HeaderBuilder {
  Map<String, String> _headers = {};
  Map<String, String> build() => _headers;

  HeaderBuilder contentTypeJson() {
    _headers["Content-Type"] = "application/json";
    return this;
  }

  HeaderBuilder withToken() {
    _headers["Authorization"] = TokenManager().accessToken;
    return this;
  }

  Future<HeaderBuilder> withRefreshToken() async {
    _headers["Authorization"] = await TokenManager().getRefreshToken();
    return this;
  }

  HeaderBuilder withCookie(String? cookie) {
    _headers["cookie"] = cookie ?? "";
    return this;
  }
}
