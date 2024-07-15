import 'package:p_cube_plus_application/remote/models/user_profile_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserProfileProvider extends ApiProviderBase<UserProfileDTO> {
  UserProfileProvider() : super(getFunction: UserProfileApi().get);

  @override
  Future<UserProfileDTO> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}
