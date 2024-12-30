import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class DebugRepositoryImpl implements DebugRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();

  @override
  bool getIsMocking() {
    return sharedPreferenceLocalDatasource.isMocking;
  }

  @override
  void setIsMocking(bool value) {
    sharedPreferenceLocalDatasource.isMocking = value;
  }

  @override
  double getMockDelay() {
    return sharedPreferenceLocalDatasource.mockDelay;
  }

  @override
  void setMockDelay(double value) {
    sharedPreferenceLocalDatasource.mockDelay = value;
  }

  @override
  bool getIsTestingException() {
    return sharedPreferenceLocalDatasource.isTestingException;
  }

  @override
  void setIsTestingException(bool value) {
    sharedPreferenceLocalDatasource.isTestingException = value;
  }
}
