import 'package:p_cube_plus_application/remote/models/warning_dto.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/warning_api.dart';

class WarningProvider extends ApiProviderBase<WarningDTO> {
  WarningProvider() : super(getFunction: WarningApi().get);

  @override
  Future<WarningDTO> refresh({Map<String, String>? queryParams}) async {
    return await super.refresh(queryParams: queryParams);
  }
}
