import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateIsTestingExceptionUseCase {
  final _debugRepository = GetIt.I.get<DebugRepository>();

  void call(bool value) {
    return _debugRepository.setIsTestingException(value);
  }
}
