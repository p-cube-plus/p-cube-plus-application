class ConfirmAuthCodeResponseDTO {
  final bool isVerified;

  ConfirmAuthCodeResponseDTO({
    required this.isVerified,
  });

  factory ConfirmAuthCodeResponseDTO.fromJson(Map<String, dynamic> json) {
    return ConfirmAuthCodeResponseDTO(
      isVerified: json['is_verified'],
    );
  }
}
