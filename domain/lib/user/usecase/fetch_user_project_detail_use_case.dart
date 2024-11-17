import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:get_it/get_it.dart';

class FetchUserProjectDetailUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<List<UserProjectDetail>> call() {
    return _userRepository.getUserProjectDetail();
  }
}
