sealed class WebViewSettingEvent {}

class ShowLoadingWebViewSettingEvent extends WebViewSettingEvent {}

class CloseLoadingWebViewSettingEvent extends WebViewSettingEvent {}

class ShowToastWebViewSettingEvent extends WebViewSettingEvent {
  final String message;
  ShowToastWebViewSettingEvent(this.message);
}

class SuccessLoadUrlInfoWebViewSettingEvent extends WebViewSettingEvent {
  final String url;
  SuccessLoadUrlInfoWebViewSettingEvent(this.url);
}
