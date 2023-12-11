import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_profile_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_project_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_warning_provider.dart';

class UserDataProvider extends CompositeProviderBase {
  UserDataProvider(
    UserProfileProvider profileProvider,
    UserProjectProvider projectProvider,
    UserWarningProvider warningProvider,
  ) : super(providerMap: {
          #UserProfileProvider: profileProvider,
          #UserProjectProvider: projectProvider,
          #UserWarningProvider: warningProvider,
        });
}
