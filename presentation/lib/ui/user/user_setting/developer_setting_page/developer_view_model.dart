import 'package:domain/debug/usecases/fetch_is_mocking_use_case.dart';
import 'package:domain/debug/usecases/fetch_is_testing_empty_data_use_case.dart';
import 'package:domain/debug/usecases/fetch_is_testing_exception_use_case.dart';
import 'package:domain/debug/usecases/update_is_mocking_use_case.dart';
import 'package:domain/debug/usecases/update_is_testing_empty_data_use_case.dart';
import 'package:domain/debug/usecases/update_is_testing_exception_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';

class DeveloperViewModel extends BaseViewModel<void, void> {
  final _fetchIsMockingUseCase = FetchIsMockingUseCase();
  final _updateIsMockingUseCase = UpdateIsMockingUseCase();
  late bool isMocking = _fetchIsMockingUseCase.call();

  void updateIsMocking() {
    isMocking = !isMocking;
    _updateIsMockingUseCase(isMocking);
    notifyListeners();
  }

  final _fetchIsTestingEmptyDataUseCase = FetchIsTestingEmptyDataUseCase();
  final _updateIsTestingEmptyDataUseCase = UpdateIsTestingEmptyDataUseCase();
  late bool isTestingEmptyData = _fetchIsTestingEmptyDataUseCase.call();

  void updateIsTestingEmptyData() {
    isTestingEmptyData = !isTestingEmptyData;
    _updateIsTestingEmptyDataUseCase(isTestingEmptyData);
    notifyListeners();
  }

  final _fetchIsTestingExceptionUseCase = FetchIsTestingExceptionUseCase();
  final _updateIsTestingExceptionUseCase = UpdateIsTestingExceptionUseCase();
  late bool isTestingException = _fetchIsTestingExceptionUseCase.call();

  void updateIsTestingException() {
    isTestingException = !isTestingException;
    _updateIsTestingExceptionUseCase(isTestingException);
    notifyListeners();
  }
}
