class SendAuthCodeToSmsResponseDTO {
  bool isSuccess;
  SendAuthCodeToSmsResponseDTO({
    required this.isSuccess,
  });

  factory SendAuthCodeToSmsResponseDTO.fromJson(Map<String, dynamic> map) {
    return SendAuthCodeToSmsResponseDTO(
      isSuccess: map['is_success'] as bool,
    );
  }
}
