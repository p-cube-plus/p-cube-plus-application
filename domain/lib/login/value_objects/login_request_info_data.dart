import 'package:meta/meta.dart';

// TODO: API에서 발송된 인증번호를 가져올 수 있는지 확인 필요.
@immutable
class LoginRequestInfoData {
  final bool isValid;
  //final String authNumber;

  const LoginRequestInfoData({
    required this.isValid,
    //required this.authNumber,
  });
}
