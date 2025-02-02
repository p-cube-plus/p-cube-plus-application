import 'package:domain/app_configuration/usecases/fetch_web_view_url_use_case.dart';
import 'package:domain/app_configuration/usecases/update_web_view_url_use_case.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/web_view_setting/web_view_setting_event.dart';

class WebViewSettingViewModel extends BaseViewModel<WebViewSettingEvent> {
  final _fetchWebViewUrlUseCase = FetchWebViewUrlUseCase();
  final _updateWebViewUrlUseCase = UpdateWebViewUrlUseCase();
  var isLoadingWebViewUrl = false;

  WebViewSettingViewModel() {
    fetchWebViewUrl();
  }

  void fetchWebViewUrl() async {
    isLoadingWebViewUrl = true;
    notifyListeners();

    final newWebViewInfo = await _fetchWebViewUrlUseCase.call().getOrNull();

    if (newWebViewInfo == null) {
      triggerEvent(
          ShowToastWebViewSettingEvent("동아리 소개 웹주소 가져오기에 실패했습니다.\n새로고침해주세요."));
    } else {
      triggerEvent(SuccessLoadUrlInfoWebViewSettingEvent(newWebViewInfo));
    }

    isLoadingWebViewUrl = false;
    notifyListeners();
  }

  void updateWebViewInformation(
    String newUrl,
  ) async {
    triggerEvent(ShowLoadingWebViewSettingEvent());
    await _updateWebViewUrlUseCase.call(newUrl).onFailure((e) {
      triggerEvent(
          ShowToastWebViewSettingEvent("동아리 소개 웹주소 업데이트에 실패했습니다.\n재시도해주세요."));
    });

    triggerEvent(CloseLoadingWebViewSettingEvent());
    triggerEvent(ShowToastWebViewSettingEvent("동아리 소개 웹주소가 수정되었습니다."));
  }
}
