import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class FetchMockDelayUseCase {
  final _debugRepository = GetIt.I.get<DebugRepository>();

  double call() {
    return _debugRepository.getMockDelay();
  }
}
