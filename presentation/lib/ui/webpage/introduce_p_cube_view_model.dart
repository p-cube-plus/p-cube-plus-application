import 'package:domain/app_configuration/usecases/fetch_web_view_url_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';

class IntroducePCubeViewModel extends BaseViewModel {
  final _fetchWebViewUrlUseCase = FetchWebViewUrlUseCase();

  Future<String> fetchWebViewUrl() async {
    return await _fetchWebViewUrlUseCase();
  }
}
