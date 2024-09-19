class ValidateUserBodyDTO {
  String name;
  String phoneNumber;
  String? fcmToken;
  ValidateUserBodyDTO({
    required this.name,
    required this.phoneNumber,
    required this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone_number': phoneNumber,
      'fcm_token': fcmToken,
    };
  }
}
