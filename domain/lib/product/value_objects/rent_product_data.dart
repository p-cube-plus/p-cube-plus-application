import 'package:domain/product/value_objects/rent_product_status_data.dart';

class RentProductData {
  final int code;
  final bool isAvailable;
  final String name;
  final String category;
  final String? location;
  final String? detailLocation;
  final String? modelName;
  final RentProductStatusData status;
  final String? author;
  final String? publisher;

  RentProductData({
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
}
