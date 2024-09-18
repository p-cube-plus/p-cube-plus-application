class ConfirmAuthCodeBodyDTO {
  final String _authCode;
  ConfirmAuthCodeBodyDTO(this._authCode);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': _authCode,
    };
  }
}
