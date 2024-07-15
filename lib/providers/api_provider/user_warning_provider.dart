import 'package:p_cube_plus_application/remote/models/user_warning_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserWarningProvider extends ApiProviderBase<UserWarningDTO> {
  UserWarningProvider() : super(getFunction: UserWarningApi().get);

  @override
  Future<UserWarningDTO> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}
