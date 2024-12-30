import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateMockDelayUseCase {
  final _debugRepository = GetIt.I.get<DebugRepository>();

  void call(double value) {
    return _debugRepository.setMockDelay(value);
  }
}
