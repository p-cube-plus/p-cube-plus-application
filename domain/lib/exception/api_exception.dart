class ApiException implements Exception {
  String mothodType;
  String inputUri;
  String? inputHeader;
  String? inputBody;
  int statusCode;
  String errorBody;
  ApiException({
    required this.mothodType,
    required this.inputUri,
    required this.inputHeader,
    required this.inputBody,
    required this.statusCode,
    required this.errorBody,
  });
}
