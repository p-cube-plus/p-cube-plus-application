import 'package:p_cube_plus_application/models/warning.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/warning_api.dart';

class WarningProvider extends ApiProviderBase<Warning> {
  WarningProvider() : super(client: new WarningApi());

  @override
  Future<Warning> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}
