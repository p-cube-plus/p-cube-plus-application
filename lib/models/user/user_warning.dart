import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserWarning {
  final totalWarning;

  UserWarning({
    required this.totalWarning,
  });

  factory UserWarning.fromJson(Map<String, dynamic> json) {
    return UserWarning(
      totalWarning: json['total_warning'],
    );
  }

  Map<String, dynamic> toJson() => {
        'total_warning': totalWarning,
      };
}
