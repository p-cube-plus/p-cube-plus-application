import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateIsMockingUseCase {
  final _debugRepository = GetIt.I.get<DebugRepository>();

  void call(bool value) {
    return _debugRepository.setIsMocking(value);
  }
}
