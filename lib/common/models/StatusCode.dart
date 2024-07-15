enum StatusCode {
  UnknownException(-1),
  OK(200),
  BadRequest(400),
  Unauthorized(401),
  Forbidden(403),
  NotFound(404),
  InternalServerError(500),
  ;

  const StatusCode(this.value);
  final value;

  static get(int code) =>
      StatusCode.values.firstWhere((code) => code.value == code,
          orElse: () => StatusCode.UnknownException);
}
