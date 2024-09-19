import 'package:domain/login/value_objects/auth_token_data.dart';
import 'package:meta/meta.dart';

@immutable
class LoginUserInfoData {
  final bool isMember;
  final AuthTokenData? tokenData;

  const LoginUserInfoData({
    required this.isMember,
    required this.tokenData,
  });
}
