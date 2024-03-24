import 'package:p_cube_plus_application/models/user/user_warning.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserWarningProvider extends ApiProviderBase<UserWarning> {
  UserWarningProvider() : super(getFunction: UserWarningApi().get);

  @override
  Future<UserWarning> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}
