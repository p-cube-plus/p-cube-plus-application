import 'package:p_cube_plus_application/models/user/user_profile.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserProfileProvider extends ApiProviderBase<UserProfile> {
  UserProfileProvider() : super(client: new UserProfileApi());

  @override
  Future<UserProfile> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}
