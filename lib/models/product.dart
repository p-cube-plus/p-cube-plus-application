import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product {
  final int id;
  final bool isAvailable;
  final String name;
  final String category;
  final String location;
  final String status;
  final String? author;
  final String? publisher;

  Product({
    required this.id,
    required this.isAvailable,
    required this.name,
    required this.category,
    required this.location,
    required this.status,
    this.author,
    this.publisher,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      isAvailable: json['is_available'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      status: json['status'],
      author: json['author'],
      publisher: json['publisher'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_available': isAvailable,
        'name': name,
        'category': category,
        'location': location,
        'status': status,
        'author': author,
        'publisher': publisher,
      };
}
