import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_setting_viewmodel.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_appbar.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';
import 'package:provider/provider.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

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
  late TextEditingController _textEditingContoller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _textEditingContoller = TextEditingController();
    Future.microtask(() => _setEventListener());
  }

  @override
  void dispose() {
    _textEditingContoller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case ExecutiveAlarmSettingState.popPage:
          _popPage();
        case ExecutiveAlarmSettingState.showProgressDialog:
          _showProgressDialog();
        case ExecutiveAlarmSettingState.dismissProgressDialog:
          _dismissProgressDialog();
        case ExecutiveAlarmSettingState.setSettingText:
          _setSettingText();
      }
    });
  }

  /// FutureBuilder 내부에 TextField가 있을 때 재빌드되는 오류 참고
  /// https://stackoverflow.com/questions/56326263/textfield-reloads-futurebuilder-when-pressed-left-in-flutter/56334027
  @override
  Widget build(BuildContext context) {
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
                watchWidget((viewModel) => viewModel.isSettingOn,
                    (context, isSettingOn) {
                  return DefaultToggleTile(
                    title: "알림 켜짐",
                    key: UniqueKey(),
                    value: isSettingOn,
                    onChanged: (bool isOn) {
                      read(context).setSettingOn(isOn);
                    },
                  );
                }),
                const SizedBox(height: 16),
                watchWidget((viewModel) => viewModel.isSettingOn,
                    (context, isSettingOn) {
                  if (isSettingOn) {
                    return GestureDetector(
                      onTap: () => _onTapTextField(),
                      child: RoundedBorder(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Row(
                          children: [
                            Text(
                              "회의",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).neutral60,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: DefaultTextField(
                                inputController: _textEditingContoller,
                                focusNode: _focusNode,
                                textType: TextInputType.number,
                                textAlign: TextAlign.end,
                                fontSize: 22,
                                maxLine: 1,
                                maxLength: 3,
                                contentPadding: 0,
                                showCursor: false,
                                enableInteractiveSelection: false,
                                onChanged: (newText) => _onChangedText(newText),
                              ),
                            ),
                            Text(
                              "시간 전",
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).neutral100,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 16),
                            SvgPicture.asset(
                              asset.down,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).neutral40,
                                BlendMode.srcIn,
                              ),
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return RoundedBorder(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      color: Theme.of(context).neutral10,
                      child: Text(
                        "알림이 꺼져있어요.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).neutral40,
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
        bottomContent: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: ElevatedButton(
            onPressed: () => _onClickSaveButton(),
            child: SizedBox(
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

  void _onClickSaveButton() {
    read(context).saveSetting();
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
            read(context).saveSettingWithPopPage();
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
    _focusNode.unfocus();
    if (_textEditingContoller.text.isEmpty) {
      _textEditingContoller.text = "0";
    }
  }

  void _onChangedText(String newText) {
    if (newText.isEmpty) {
      newText = "0";
    }
    var inputHour = int.parse(newText);
    if (inputHour > 24) {
      if (inputHour / 10 >= 24) {
        inputHour = int.parse(newText.substring(2));
      } else {
        Fluttertoast.showToast(msg: "24시간을 넘을 수 없습니다!");
        inputHour = 24;
      }
    }
    read(context).setSettingHour(inputHour);
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

  void _setSettingText() {
    _textEditingContoller.text = read(context).setting.reminderHours.toString();
  }
}
