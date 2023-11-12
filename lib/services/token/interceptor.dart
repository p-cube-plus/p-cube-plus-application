import 'package:http_interceptor/http_interceptor.dart';
import 'package:p_cube_plus_application/services/token/auth_api.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String accessToken = TokenManager().getAccessToken().toString();
    data.headers['Authorization'] = 'Bearer ' + accessToken;
    data.headers['Content-Type'] = 'application/json';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int maxRetryAttempts = 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      await AuthApi().refresh();
      return true;
    }
    return false;
  }
}
