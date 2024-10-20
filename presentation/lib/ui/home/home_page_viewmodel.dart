import 'package:domain/user/usecase/fetch_is_executive_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/home/home_page_event.dart';

class HomePageViewModel extends BaseViewModel<HomePageEvent, void> {
  final fetchIsExecutiveUseCase = FetchIsExecutiveUseCase();

  bool isExecutive = false;

  HomePageViewModel() {
    fetchIsExecutiveUseCase()
        .then((result) => isExecutive = result)
        .onError((error, trace) {
      changeViewState(HomePageEventShowToast(message: "유저정보 접근 실패"));
      return false;
    });
  }
}
