import 'package:domain/product/value_objects/product_type.dart';

class SearchResultProduct {
  final String barCode;
  final String productName;
  final ProductType productType;
  final String? rentUserName; // 대여자가 이미 존재할 때
  SearchResultProduct({
    required this.barCode,
    required this.productName,
    required this.productType,
    required this.rentUserName,
  });
}
