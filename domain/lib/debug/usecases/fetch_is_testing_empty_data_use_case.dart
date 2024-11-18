import 'package:domain/debug/repository/debug_repository.dart';
import 'package:get_it/get_it.dart';

class FetchIsTestingEmptyDataUseCase {
  final _debugRepository = GetIt.I.get<DebugRepository>();

  bool call() {
    return _debugRepository.getIsTestingEmptyData();
  }
}
