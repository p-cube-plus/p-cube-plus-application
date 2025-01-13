import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/debug/usecases/fetch_fcm_token_use_case.dart';
import 'package:domain/debug/usecases/fetch_is_mocking_use_case.dart';
import 'package:domain/debug/usecases/fetch_is_testing_exception_use_case.dart';
import 'package:domain/debug/usecases/fetch_mock_delay_use_case.dart';
import 'package:domain/debug/usecases/update_is_mocking_use_case.dart';
import 'package:domain/debug/usecases/update_is_testing_exception_use_case.dart';
import 'package:domain/debug/usecases/update_mock_delay_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';

class DeveloperViewModel extends BaseViewModel<void> {
  final _fetchIsMockingUseCase = FetchIsMockingUseCase();
  final _updateIsMockingUseCase = UpdateIsMockingUseCase();
  final _fetchFcmTokenUseCase = FetchFcmTokenUseCase();
  late bool isMocking = _fetchIsMockingUseCase.call();

  void updateIsMocking() {
    isMocking = !isMocking;
    _updateIsMockingUseCase(isMocking);
    notifyListeners();
  }

  final _fetchMockDelayUseCase = FetchMockDelayUseCase();
  final _updateMockDelayUseCase = UpdateMockDelayUseCase();
  late double mockDelay = _fetchMockDelayUseCase.call();

  void updatemockDelay(double newValue) {
    mockDelay = newValue;
    _updateMockDelayUseCase(newValue);
    notifyListeners();
  }

  Future<String?> fetchFcmToken() => _fetchFcmTokenUseCase().getOrDefault("");

  final _fetchIsTestingExceptionUseCase = FetchIsTestingExceptionUseCase();
  final _updateIsTestingExceptionUseCase = UpdateIsTestingExceptionUseCase();
  late bool isTestingException = _fetchIsTestingExceptionUseCase.call();

  void updateIsTestingException() {
    isTestingException = !isTestingException;
    _updateIsTestingExceptionUseCase(isTestingException);
    notifyListeners();
  }
}
