import 'package:domain/models/login/login_request_info_data.dart';

class LoginRequestInfoDTO {
  final bool isValid;
  final String? cookie;

  LoginRequestInfoDTO({
    required this.isValid,
    required this.cookie,
  });
}

extension LoginRequestInfoDTOExtension on LoginRequestInfoDTO {
  LoginRequestInfoData toDomain() {
    return LoginRequestInfoData(
      isValid: isValid,
      authNumber: "",
    );
  }
}
