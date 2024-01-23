import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RequestInfo {
  final bool isValid;
  final String? cookie;

  RequestInfo({
    required this.isValid,
    required this.cookie,
  });

  factory RequestInfo.fromJson(
    Map<String, dynamic> header,
    Map<String, dynamic> body,
  ) {
    return RequestInfo(
      isValid: body['is_success'],
      cookie: header['set-cookie'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_success': isValid,
      };
}
