import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_setting_viewmodel.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';

class ExecutiveAlarmSettingPage extends StatelessWidget {
  final NotificationType notificationType;

  const ExecutiveAlarmSettingPage({
    super.key,
    required this.notificationType,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ExecutiveAlarmSettingViewModel(notificationType: notificationType),
      child: _ExecutiveAlarmSettingPage(),
    );
  }
}

class _ExecutiveAlarmSettingPage extends StatefulWidget {
  @override
  State<_ExecutiveAlarmSettingPage> createState() =>
      _ExecutiveAlarmSettingPageState();
}

class _ExecutiveAlarmSettingPageState extends State<_ExecutiveAlarmSettingPage>
    with ViewModel<ExecutiveAlarmSettingViewModel> {
  final _textEditingContoller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setEventListener());
  }

  @override
  void dispose() {
    _textEditingContoller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setEventListener() {
    read(context).uiEventStream.listen((event) {
      switch (event) {
        case ExecutiveAlarmSettingState.popPage:
          _popPage();
        case ExecutiveAlarmSettingState.showProgressDialog:
          _showProgressDialog();
        case ExecutiveAlarmSettingState.dismissProgressDialog:
          _dismissProgressDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onPop(didPop),
      child: DefaultPage(
        appbar: DefaultAppBar(
          centerTitle: "${read(context).notificationType.name} 알림",
        ),
        content: GestureDetector(
          onTap: () => _unfocusTextField(),
          child: DefaultContent(
            child: Column(
              children: [
                DefaultFutureBuilder(
                  fetchData: read(context).fetchNotificationSettingOn(),
                  showOnLoadedWidget: (context, isOn) {
                    return DefaultToggleTile(
                      title: "알림 켜짐",
                      value: isOn,
                      onChanged: (bool isOn) {
                        read(context).triggerEvent(
                            ExecutiveAlarmSettingEvent.saveSettingOn);
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                DefaultFutureBuilder(
                  fetchData: read(context).fetchNotificationSettingHour(),
                  showOnLoadedWidget: (context, alarmTime) {
                    _textEditingContoller.text = alarmTime.toString();
                    return watchWidget((viewModel) => viewModel.isSettingOn,
                        (isSettingOn) {
                      if (isSettingOn) {
                        return GestureDetector(
                          onTap: () => _onTapTextField(),
                          child: RoundedBorder(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  "회의",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.neutral60,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: DefaultTextField(
                                    inputController: _textEditingContoller,
                                    focusNode: _focusNode,
                                    textDirection: TextDirection.rtl,
                                    textType: TextInputType.number,
                                    fontSize: 22,
                                    maxLine: 1,
                                    maxLength: 3,
                                    showCursor: false,
                                    enableInteractiveSelection: false,
                                    onChanged: (newText) =>
                                        _onChangedText(newText),
                                  ),
                                ),
                                Text(
                                  "시간 전",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: theme.neutral100,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: theme.neutral40,
                                  size: 32,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return RoundedBorder(
                          color: theme.neutral40,
                          child: Text("알림이 꺼져있어요."),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        bottomContent: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: ElevatedButton(
            onPressed: () => read(context)
                .triggerEvent(ExecutiveAlarmSettingEvent.saveSetting),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Center(
                child: Text(
                  "저장",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  void _onPop(bool didPop) {
    if (didPop) return;

    final isEdited =
        read(context).isEdited(int.parse(_textEditingContoller.text));
    if (!isEdited) {
      Navigator.pop(context);
    } else {
      DialogBuilder().build(
        context,
        DefaultAlert(
          title: "저장하시겠습니까?",
          description: "저장되지 않는 변경사항이 있습니다.",
          messageType: MessageType.okCancel,
          onTapOk: () {
            read(context).triggerEvent(
                ExecutiveAlarmSettingEvent.saveSettingWithPopPage);
          },
          onTapCancel: () {
            _popPage();
          },
        ),
      );
    }
  }

  void _onTapTextField() {
    if (_focusNode.hasFocus) {
      _unfocusTextField();
    } else {
      _focusNode.requestFocus();
    }
  }

  void _unfocusTextField() {
    _focusNode.unfocus(disposition: UnfocusDisposition.scope);
    if (_textEditingContoller.text.isEmpty) {
      _textEditingContoller.text = "0";
    }
  }

  void _onChangedText(String newText) {
    var inputHour = int.parse(newText);
    if (inputHour > 24) {
      if (inputHour / 10 >= 24) {
        inputHour = int.parse(newText.substring(2));
      } else {
        Fluttertoast.showToast(msg: "24시간을 넘을 수 없습니다!");
        inputHour = 24;
      }
    }
    _textEditingContoller.text = inputHour.toString();
  }

  void _popPage() {
    if (mounted) Navigator.pop(context);
  }

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _dismissProgressDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
