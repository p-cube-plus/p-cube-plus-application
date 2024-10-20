sealed class HomePageEvent {}

class HomePageEventShowToast implements HomePageEvent {
  String message;
  HomePageEventShowToast({
    required this.message,
  });
}
