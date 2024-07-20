class ErrorDto {
  int? errorCode;
  String? errorType;

  ErrorDto({
    required this.errorCode,
    required this.errorType,
  });

  factory ErrorDto.fromJson(Map<String, dynamic> json) {
    return ErrorDto(
      errorCode: json["status"],
      errorType: json["error"],
    );
  }
}
