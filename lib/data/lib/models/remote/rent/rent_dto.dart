import 'rent_product_dto.dart';

class RentDTO {
  final RentProductDTO product;
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
      product: RentProductDTO.fromJson(json['product']),
      deadline: DateTime.parse(json['deadline']),
      rentDay: DateTime.parse(json['rent_day']),
      dDay: json['d_day'],
      returnDay: DateTime.parse(json['return_day']),
    );
  }
}
