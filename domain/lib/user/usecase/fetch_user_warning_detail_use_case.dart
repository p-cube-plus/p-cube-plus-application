import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';
import 'package:get_it/get_it.dart';

class FetchUserWarningDetailUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<UserWarningDetail> call() {
    return _userRepository.getUserWarningDetail();
  }
}
