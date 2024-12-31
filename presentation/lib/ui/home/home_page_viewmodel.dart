import 'package:domain/user/usecase/fetch_is_executive_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomePageViewModel extends BaseViewModel<void> {
  final _fetchIsExecutiveUseCase = FetchIsExecutiveUseCase();

  Future<bool> fetchIsExecutive() => _fetchIsExecutiveUseCase();
}
