import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:get_it/get_it.dart';

class FetchUserWarningUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<UserWarning> call() {
    return _userRepository.getUserCumulativeWarning();
  }
}
