import 'rent_product_response_dto.dart';

class RentResponseDTO {
  final RentProductResponseDTO product;
  final DateTime deadline;
  final DateTime rentDay;
  final int dDay;
  final DateTime? returnDay;

  RentResponseDTO({
    required this.product,
    required this.deadline,
    required this.rentDay,
    required this.dDay,
    required this.returnDay,
  });

  factory RentResponseDTO.fromJson(Map<String, dynamic> json) {
    return RentResponseDTO(
      product: RentProductResponseDTO.fromJson(json['product']),
      deadline: DateTime.parse(json['deadline']),
      rentDay: DateTime.parse(json['rent_day']),
      dDay: json['d_day'],
      returnDay: DateTime.parse(json['return_day']),
    );
  }
}
