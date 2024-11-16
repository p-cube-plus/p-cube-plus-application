import 'package:domain/member/value_objects/member_position_type.dart';
import 'package:domain/user/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class FetchIsExecutiveUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<bool> call() async {
    final userData = await _userRepository.getUserProfile();
    return userData.positionType is ExecutiveTeam;
  }
}
