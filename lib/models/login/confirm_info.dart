import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ConfirmInfo {
  final bool isVerified;

  ConfirmInfo({
    required this.isVerified,
  });

  factory ConfirmInfo.fromJson(Map<String, dynamic> json) {
    return ConfirmInfo(
      isVerified: json['is_verified'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_verified': isVerified,
      };
}
