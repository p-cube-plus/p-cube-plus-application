import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/fee/usecases/fetch_account_information_use_case.dart';
import 'package:domain/fee/usecases/update_account_information_use_case.dart';
import 'package:domain/fee/value_object/account_information.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/fee_setting/fee_setting_event.dart';

class FeeSettingViewModel extends BaseViewModel<FeeSettingEvent> {
  final _fetchAccountInformationUseCase = FetchAccountInformationUseCase();
  final _updateAccountInformationUseCase = UpdateAccountInformationUseCase();

  var isLoadingFeeSetting = false;

  FeeSettingViewModel() {
    fetchAccountInformation();
  }

  void fetchAccountInformation() async {
    isLoadingFeeSetting = true;
    notifyListeners();

    final newFeeInfo = await _fetchAccountInformationUseCase.call().getOrNull();

    if (newFeeInfo == null) {
      triggerEvent(ShowToastFeeSettingEvent("회비계좌 가져오기에 실패했습니다.\n새로고침해주세요."));
    } else {
      triggerEvent(SuccessLoadFeeInfoFeeSettingEvent(newFeeInfo));
    }

    isLoadingFeeSetting = false;
    notifyListeners();
  }

  void updateAccountInformation(
    String accountBank,
    String accountNumber,
    String accountOwnerName,
  ) async {
    triggerEvent(ShowLoadingFeeSettingEvent());
    await _updateAccountInformationUseCase
        .call(AccountInformation(
      accountBank: accountBank,
      accountNumber: accountNumber,
      accountOwnerName: accountOwnerName,
    ))
        .onFailure((e) {
      triggerEvent(ShowToastFeeSettingEvent("회비계좌 업데이트에 실패했습니다.\n재시도해주세요."));
    });

    triggerEvent(CloseLoadingFeeSettingEvent());
    triggerEvent(ShowToastFeeSettingEvent("회비계좌가 수정되었습니다."));
  }
}
