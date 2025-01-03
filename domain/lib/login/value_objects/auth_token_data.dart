import 'package:meta/meta.dart';

@immutable
class AuthTokenData {
  final String accessToken;
  final String refreshToken;

  const AuthTokenData({
    required this.accessToken,
    required this.refreshToken,
  });
}
