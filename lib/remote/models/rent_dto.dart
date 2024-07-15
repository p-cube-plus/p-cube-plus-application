class RentDTO {
  final ProductDTO product;
  final DateTime deadline;
  final DateTime rentDay;
  final int dDay;
  final DateTime? returnDay;

  RentDTO({
    required this.product,
    required this.deadline,
    required this.rentDay,
    required this.dDay,
    required this.returnDay,
  });

  factory RentDTO.fromJson(Map<String, dynamic> json) {
    return RentDTO(
      product: ProductDTO.fromJson(json['product']),
      deadline: DateTime.parse(json['deadline']),
      rentDay: DateTime.parse(json['rent_day']),
      dDay: json['d_day'],
      returnDay: DateTime.parse(json['return_day']),
    );
  }
}

class ProductDTO {
  final int code;
  final bool isAvailable;
  final String name;
  final String category;
  final String? location; // ex. 서랍..
  final String? detailLocation; // ex. 서랍 2번째 줄..?
  final String? modelName; // ex. 모니터 종류?
  final ProductStatusDTO status;
  final String? author; // 물품 주인 (기증자 등)
  final String? publisher;

  ProductDTO({
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

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      code: json['code'],
      isAvailable: json['is_available'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      detailLocation: json['detail_location'],
      modelName: json['model_name'],
      status: ProductStatusDTO.fromJson(json['status']),
      author: json['author'],
      publisher: json['publisher'],
    );
  }
}

class ProductStatusDTO {
  final String value; // ["대여 가능", "대여 중", "대여 불가"]
  final String? rentUser;

  ProductStatusDTO({
    required this.value,
    required this.rentUser,
  });

  factory ProductStatusDTO.fromJson(Map<String, dynamic> json) {
    return ProductStatusDTO(
      value: json['value'],
      rentUser: json['rent_user'],
    );
  }
}
