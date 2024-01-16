import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RequestInfo {
  final bool isValid;

  RequestInfo({
    required this.isValid,
  });

  factory RequestInfo.fromJson(Map<String, dynamic> json) {
    return RequestInfo(
      isValid: json['is_success'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_success': isValid,
      };
}
