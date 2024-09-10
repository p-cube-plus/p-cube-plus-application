import 'package:domain/product/models/rent_product_data.dart';

class RentData {
  final RentProductData product;
  final DateTime deadline;
  final DateTime rentDay;
  final int dDay;
  final DateTime? returnDay;

  RentData({
    required this.product,
    required this.deadline,
    required this.rentDay,
    required this.dDay,
    required this.returnDay,
  });
}
