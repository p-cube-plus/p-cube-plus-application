class SendAuthCodeToSmsBodyDTO {
  String phoneNumber;
  SendAuthCodeToSmsBodyDTO({
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone_number': phoneNumber,
    };
  }
}
