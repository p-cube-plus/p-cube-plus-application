import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Member {
  final int id;
  final String name;
  final int partIndex;
  String getPart() => "${["디자인", "프로그래밍", "아트"][partIndex]}";

  Member({
    required this.id,
    required this.name,
    required this.partIndex,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      partIndex: json['part_index'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'part_index': partIndex,
      };
}
