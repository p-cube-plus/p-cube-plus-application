import 'package:domain/user/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class LogoutUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<void> call() {
    return _userRepository.logout();
  }
}
