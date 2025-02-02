import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/web_view_setting/web_view_setting_event.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/web_view_setting/web_view_setting_view_model.dart';
import 'package:presentation/widgets/default_progress_indicator_builder.dart';
import 'package:presentation/widgets/expandable_content.dart';
import 'package:presentation/widgets/expandable_content_text_input_item.dart';
import 'package:provider/provider.dart';

class ExpandableWebViewSettingWidget extends StatelessWidget {
  const ExpandableWebViewSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WebViewSettingViewModel(),
      child: _ExpandableWebViewSettingWidget(),
    );
  }
}

class _ExpandableWebViewSettingWidget extends StatefulWidget {
  @override
  State<_ExpandableWebViewSettingWidget> createState() =>
      _ExpandableWebViewSettingWidgetState();
}

class _ExpandableWebViewSettingWidgetState
    extends State<_ExpandableWebViewSettingWidget>
    with ViewModel<WebViewSettingViewModel> {
  late TextEditingController _urlTextController;

  @override
  void initState() {
    super.initState();
    _urlTextController = TextEditingController();
    Future.microtask(() => _setEventListener());
  }

  @override
  void dispose() {
    _urlTextController.dispose();
    super.dispose();
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case ShowLoadingWebViewSettingEvent():
          _showLoadingDialog();
        case CloseLoadingWebViewSettingEvent():
          _closeLoadingDialog();
        case ShowToastWebViewSettingEvent():
          Fluttertoast.showToast(msg: event.message);
        case SuccessLoadUrlInfoWebViewSettingEvent():
          _setUrlText(event.url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableContent(
          categoryText: "동아리 소개 페이지 정보",
          expandedWidget: watchWidget(
            (viewModel) => viewModel.isLoadingWebViewUrl,
            (context, isLoadingWebViewUrl) {
              if (isLoadingWebViewUrl) {
                return SizedBox();
              } else {
                return Column(
                  children: [
                    ExpandableContentTextInputItem(
                      keyText: "웹주소",
                      textController: _urlTextController,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus
                            ?.unfocus(disposition: UnfocusDisposition.scope);
                        read(context)
                            .updateWebViewInformation(_urlTextController.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "동아리 소개 페이지 정보 수정하기",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _setUrlText(String newWebViewUrl) {
    _urlTextController.text = newWebViewUrl;
  }

  void _showLoadingDialog() {
    DefaultProgressIndicatorBuilder().build(context);
  }

  void _closeLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
