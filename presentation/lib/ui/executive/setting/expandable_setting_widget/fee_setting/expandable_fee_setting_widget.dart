import 'package:domain/fee/value_object/account_information.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/fee_setting/fee_setting_event.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/fee_setting/fee_setting_view_model.dart';
import 'package:presentation/widgets/default_progress_indicator_builder.dart';
import 'package:presentation/widgets/expandable_content.dart';
import 'package:presentation/widgets/expandable_content_text_input_item.dart';
import 'package:provider/provider.dart';

class ExpandableFeeSettingWidget extends StatelessWidget {
  const ExpandableFeeSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeeSettingViewModel(),
      child: _ExpandableFeeSettingWidget(),
    );
  }
}

class _ExpandableFeeSettingWidget extends StatefulWidget {
  @override
  State<_ExpandableFeeSettingWidget> createState() =>
      _ExpandableFeeSettingWidgetState();
}

class _ExpandableFeeSettingWidgetState
    extends State<_ExpandableFeeSettingWidget>
    with ViewModel<FeeSettingViewModel> {
  late TextEditingController _bankTextController;
  late TextEditingController _accountNumberTextController;
  late TextEditingController _accountOwnerNameTextController;

  @override
  void initState() {
    super.initState();
    _bankTextController = TextEditingController();
    _accountNumberTextController = TextEditingController();
    _accountOwnerNameTextController = TextEditingController();
    Future.microtask(() => _setEventListener());
  }

  @override
  void dispose() {
    _bankTextController.dispose();
    _accountNumberTextController.dispose();
    _accountOwnerNameTextController.dispose();
    super.dispose();
  }

  void _setEventListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case ShowLoadingFeeSettingEvent():
          _showLoadingDialog();
        case CloseLoadingFeeSettingEvent():
          _closeLoadingDialog();
        case ShowToastFeeSettingEvent():
          Fluttertoast.showToast(msg: event.message);
        case SuccessLoadFeeInfoFeeSettingEvent():
          _setAccountInfo(event.accountInfo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableContent(
          categoryText: "회비계좌정보",
          expandedWidget: watchWidget(
            (viewModel) => viewModel.isLoadingFeeSetting,
            (context, isLoadingFeeSetting) {
              if (isLoadingFeeSetting) {
                return SizedBox();
              } else {
                return Column(
                  children: [
                    ExpandableContentTextInputItem(
                      keyText: "은행명",
                      textController: _bankTextController,
                    ),
                    SizedBox(height: 8),
                    ExpandableContentTextInputItem(
                      keyText: "계좌번호",
                      textController: _accountNumberTextController,
                    ),
                    SizedBox(height: 8),
                    ExpandableContentTextInputItem(
                      keyText: "계좌소유자",
                      textController: _accountOwnerNameTextController,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus
                            ?.unfocus(disposition: UnfocusDisposition.scope);
                        read(context).updateAccountInformation(
                          _bankTextController.text,
                          _accountNumberTextController.text,
                          _accountOwnerNameTextController.text,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "회비계좌정보 수정하기",
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

  void _setAccountInfo(AccountInformation newInfo) {
    _bankTextController.text = newInfo.accountBank;
    _accountNumberTextController.text = newInfo.accountNumber;
    _accountOwnerNameTextController.text = newInfo.accountOwnerName;
  }

  void _showLoadingDialog() {
    DefaultProgressIndicatorBuilder().build(context);
  }

  void _closeLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
