class RentProductStatusDTO {
  final String value; // ["대여 가능", "대여 중", "대여 불가"]
  final String? rentUser;

  RentProductStatusDTO({
    required this.value,
    required this.rentUser,
  });

  factory RentProductStatusDTO.fromJson(Map<String, dynamic> json) {
    return RentProductStatusDTO(
      value: json['value'],
      rentUser: json['rent_user'],
    );
  }
}
