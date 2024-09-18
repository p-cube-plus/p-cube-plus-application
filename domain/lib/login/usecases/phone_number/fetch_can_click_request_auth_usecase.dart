// 숫자가 12자 이상일 때부터 클릭 가능하다. ex) XXX-XXX-XXXX
class FetchCanClickRequestAuthUsecase {
  bool call(String inputPhoneNumber) {
    return inputPhoneNumber.length >= 12;
  }
}
