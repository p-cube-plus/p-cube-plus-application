// 번호 형식이 XXX-XXXX-XXXX 라면 번호 최대길이로 인식한다.
class FetchIsPhoneNumberMaxLengthUsecase {
  call(String inputPhoneNumber) {
    return inputPhoneNumber.length >= 13;
  }
}
