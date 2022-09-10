import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Rent {
  final int id;
  final String name;
  final DateTime deadline;

  Rent({
    required this.id,
    required this.name,
    required this.deadline,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['id'],
      name: json['name'],
      deadline: DateTime.parse(json['deadline']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'deadline': deadline.toString(),
      };
}
