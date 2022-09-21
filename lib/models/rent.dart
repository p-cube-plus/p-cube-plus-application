import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

@JsonSerializable()
class Rent {
  final int id;
  final int dDay;
  final DateTime date;
  final DateTime deadline;
  final Product product;

  Rent({
    required this.id,
    required this.dDay,
    required this.date,
    required this.deadline,
    required this.product,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['id'],
      dDay: json['d_day'],
      date: DateTime.parse(json['rent_day']),
      deadline: DateTime.parse(json['deadline']),
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'd_day': dDay,
        'rent_day': date.toString(),
        'deadline': deadline.toString(),
        'product': product.toJson(),
      };
}
