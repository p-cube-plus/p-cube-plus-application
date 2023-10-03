abstract class IErrorMessage implements Exception {
  String get message;
}

class UnknownError implements IErrorMessage {
  @override
  String get message => "알 수 없는 오류가 발생했습니다.";
}

class FailedToConvertJSONData implements IErrorMessage {
  @override
  String get message => "JSON 데이터 변환 실패!";
}

class FailedToGetServerData implements IErrorMessage {
  @override
  String get message => "서버 데이터 불러오기 실패!";
}

class DataLoadTimeout implements IErrorMessage {
  @override
  String get message => "데이터 로딩시간이 너무 깁니다.";
}
