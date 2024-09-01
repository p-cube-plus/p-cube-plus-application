import 'package:domain/models/login/login_confirm_info_data.dart';

class LoginConfirmInfoDTO {
  final bool isVerified;

  LoginConfirmInfoDTO({
    required this.isVerified,
  });

  factory LoginConfirmInfoDTO.fromJson(Map<String, dynamic> json) {
    return LoginConfirmInfoDTO(
      isVerified: json['is_verified'],
    );
  }
}

extension LoginConfirmInfoDTOExtension on LoginConfirmInfoDTO {
  LoginConfirmInfoData toDomain() {
    return LoginConfirmInfoData(
      isVerified: isVerified,
    );
  }
}
