class RentProductStatusData {
  final String value; // ["대여 가능", "대여 중", "대여 불가"]
  final String? rentUser;

  RentProductStatusData({
    required this.value,
    required this.rentUser,
  });
}
