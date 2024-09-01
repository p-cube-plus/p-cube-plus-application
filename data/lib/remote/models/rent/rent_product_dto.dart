import 'package:domain/models/rent/rent_product_data.dart';

import 'rent_product_status_dto.dart';

class RentProductDTO {
  final int code;
  final bool isAvailable;
  final String name;
  final String category;
  final String? location; // ex. 서랍..
  final String? detailLocation; // ex. 서랍 2번째 줄..?
  final String? modelName; // ex. 모니터 종류?
  final RentProductStatusDTO status;
  final String? author; // 물품 주인 (기증자 등)
  final String? publisher;

  RentProductDTO({
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

  factory RentProductDTO.fromJson(Map<String, dynamic> json) {
    return RentProductDTO(
      code: json['code'],
      isAvailable: json['is_available'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      detailLocation: json['detail_location'],
      modelName: json['model_name'],
      status: RentProductStatusDTO.fromJson(json['status']),
      author: json['author'],
      publisher: json['publisher'],
    );
  }
}

extension RentProductDTOExtension on RentProductDTO {
  RentProductData toDomain() {
    return RentProductData(
      code: code,
      isAvailable: isAvailable,
      name: name,
      category: category,
      location: location,
      detailLocation: detailLocation,
      modelName: modelName,
      status: status.toDomain(),
      author: author,
      publisher: publisher,
    );
  }
}
