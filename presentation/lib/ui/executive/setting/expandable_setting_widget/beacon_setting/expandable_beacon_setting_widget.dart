import 'package:domain/attendance/value_objects/beacon_information.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/beacon_setting/beacon_setting_event.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/beacon_setting/beacon_setting_view_model.dart';
import 'package:presentation/widgets/default_progress_indicator_builder.dart';
import 'package:presentation/widgets/expandable_content.dart';
import 'package:presentation/widgets/expandable_content_text_input_item.dart';
import 'package:provider/provider.dart';

class ExpandableBeaconSettingWidget extends StatelessWidget {
  const ExpandableBeaconSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BeaconSettingViewModel(),
      child: _ExpandableBeaconSettingWidget(),
    );
  }
}

class _ExpandableBeaconSettingWidget extends StatefulWidget {
  const _ExpandableBeaconSettingWidget({super.key});

  @override
  State<_ExpandableBeaconSettingWidget> createState() =>
      _ExpandableBeaconSettingWidgetState();
}

class _ExpandableBeaconSettingWidgetState
    extends State<_ExpandableBeaconSettingWidget>
    with ViewModel<BeaconSettingViewModel> {
  late TextEditingController _idTextController;
  late TextEditingController _uuidTextController;
  late TextEditingController _majorTextController;
  late TextEditingController _minorTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _uuidTextController = TextEditingController();
    _majorTextController = TextEditingController();
    _minorTextController = TextEditingController();
    Future.microtask(() => _setEventListener());
  }

  @override
  void dispose() {
    _idTextController.dispose();
    _uuidTextController.dispose();
    _majorTextController.dispose();
    _minorTextController.dispose();
    super.dispose();
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case ShowLoadingBeaconSettingEvent():
          _showLoadingDialog();
        case CloseLoadingBeaconSettingEvent():
          _closeLoadingDialog();
        case ShowToastBeaconSettingEvent():
          Fluttertoast.showToast(msg: event.message);
        case SuccessLoadBeaconInfoBeaconSettingEvent():
          _setBeaconInfo(event.beaconInfo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableContent(
          categoryText: "비콘정보",
          expandedWidget: watchWidget(
            (viewModel) => viewModel.isLoadingBeaconSetting,
            (context, isLoadingBeaconSetting) {
              if (isLoadingBeaconSetting) {
                return SizedBox();
              } else {
                return Column(
                  children: [
                    ExpandableContentTextInputItem(
                      keyText: "identifier",
                      textController: _idTextController,
                    ),
                    SizedBox(height: 8),
                    ExpandableContentTextInputItem(
                      keyText: "uuid",
                      textController: _uuidTextController,
                    ),
                    SizedBox(height: 8),
                    ExpandableContentTextInputItem(
                      keyText: "major",
                      textController: _majorTextController,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    ExpandableContentTextInputItem(
                      keyText: "minor",
                      textController: _minorTextController,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus
                            ?.unfocus(disposition: UnfocusDisposition.scope);
                        read(context).updateBeaconInformation(
                          _idTextController.text,
                          _uuidTextController.text,
                          _majorTextController.text,
                          _minorTextController.text,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "비콘정보 수정하기",
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

  void _setBeaconInfo(BeaconInformation newInfo) {
    _idTextController.text = newInfo.identifier;
    _uuidTextController.text = newInfo.uuid;
    _majorTextController.text = newInfo.major.toString();
    _minorTextController.text = newInfo.minor.toString();
  }

  void _showLoadingDialog() {
    DefaultProgressIndicatorBuilder().build(context);
  }

  void _closeLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
