import 'package:data/models/remote/user/user_warning_dto.dart';

abstract class UserWarningService {
  Future<UserWarningDTO> getCurrentUserWarning();
}
