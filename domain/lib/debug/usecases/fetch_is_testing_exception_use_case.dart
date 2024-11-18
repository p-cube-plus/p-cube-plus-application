import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class FetchIsTestingExceptionUseCase {
  final _debugRepository = GetIt.I.get<DebugRepository>();

  bool call() {
    return _debugRepository.getIsTestingException();
  }
}
