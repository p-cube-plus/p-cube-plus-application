import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_profile.dart';
import 'package:get_it/get_it.dart';

class FetchUserProfileUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<UserProfile> call() {
    return _userRepository.getUserProfile();
  }
}
