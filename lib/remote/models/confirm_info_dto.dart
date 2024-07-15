class ConfirmInfoDTO {
  final bool isVerified;

  ConfirmInfoDTO({
    required this.isVerified,
  });

  factory ConfirmInfoDTO.fromJson(Map<String, dynamic> json) {
    return ConfirmInfoDTO(
      isVerified: json['is_verified'],
    );
  }
}
