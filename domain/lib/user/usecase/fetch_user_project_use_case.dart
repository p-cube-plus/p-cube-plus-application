import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:get_it/get_it.dart';

class FetchUserProjectUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<List<UserProject>> call() {
    return _userRepository.getUserProject();
  }
}
