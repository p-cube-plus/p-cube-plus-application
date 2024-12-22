import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class DeleteUserUseCase {
  final _loginRepository = GetIt.I.get<LoginRepository>();

  Future<void> call() {
    return _loginRepository.deleteUser();
  }
}
