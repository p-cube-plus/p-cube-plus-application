class RentProductResponseDTO {
  final int code;
  final bool isAvailable;
  final String name;
  final String category;
  final String? location; // ex. 서랍..
  final String? detailLocation; // ex. 서랍 2번째 줄..?
  final String? modelName; // ex. 모니터 종류?
  final RentProductStatusResponseDTO status;
  final String? author; // 물품 주인 (기증자 등)
  final String? publisher;

  RentProductResponseDTO({
    required this.code,
    required this.isAvailable,
    required this.name,
    required this.category,
    required this.location,
    required this.detailLocation,
    required this.modelName,
    required this.status,
    this.author,
    this.publisher,
  });

  factory RentProductResponseDTO.fromJson(Map<String, dynamic> json) {
    return RentProductResponseDTO(
      code: json['code'],
      isAvailable: json['is_available'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      detailLocation: json['detail_location'],
      modelName: json['model_name'],
      status: RentProductStatusResponseDTO.fromJson(json['status']),
      author: json['author'],
      publisher: json['publisher'],
    );
  }
}

class RentProductStatusResponseDTO {
  final String value; // ["대여 가능", "대여 중", "대여 불가"]
  final String? rentUser;

  RentProductStatusResponseDTO({
    required this.value,
    required this.rentUser,
  });

  factory RentProductStatusResponseDTO.fromJson(Map<String, dynamic> json) {
    return RentProductStatusResponseDTO(
      value: json['value'],
      rentUser: json['rent_user'],
    );
  }
}
