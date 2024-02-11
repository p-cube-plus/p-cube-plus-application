import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/auth_token.dart';
import 'package:p_cube_plus_application/services/auth_api.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

class TokenProvider with ChangeNotifier {
  AuthTokenRefreshApi authTokenRefreshApi = new AuthTokenRefreshApi();

  Future<AuthToken?> refreshToken() async {
    String? refreshToken = await TokenManager().getRefreshToken();
    if (refreshToken == null) return null;

    Map<String, String>? headers = {
      'Authorization': 'Bearer $refreshToken',
      'Content-Type': 'application/json',
    };
    return await authTokenRefreshApi.get(additionalHeader: headers);
  }
}
