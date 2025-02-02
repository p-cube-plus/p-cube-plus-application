import 'package:domain/attendance/usecases/fetch_beacon_information_use_case.dart';
import 'package:domain/attendance/usecases/update_beacon_information_use_case.dart';
import 'package:domain/attendance/value_objects/beacon_information.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/setting/expandable_setting_widget/beacon_setting/beacon_setting_event.dart';

class BeaconSettingViewModel extends BaseViewModel<BeaconSettingEvent> {
  final _fetchBeaconInformationUseCase = FetchBeaconInformationUseCase();
  final _updateBeaconInformationUseCase = UpdateBeaconInformationUseCase();

  var isLoadingBeaconSetting = false;

  BeaconSettingViewModel() {
    fetchBeaconInformation();
  }

  void fetchBeaconInformation() async {
    isLoadingBeaconSetting = true;
    notifyListeners();

    final newBeaconInfo =
        await _fetchBeaconInformationUseCase.call().getOrNull();

    if (newBeaconInfo == null) {
      triggerEvent(
          ShowToastBeaconSettingEvent("비콘정보 가져오기에 실패했습니다.\n새로고침해주세요."));
    } else {
      triggerEvent(SuccessLoadBeaconInfoBeaconSettingEvent(newBeaconInfo));
    }

    isLoadingBeaconSetting = false;
    notifyListeners();
  }

  void updateBeaconInformation(
    String identifier,
    String uuid,
    String major,
    String minor,
  ) async {
    triggerEvent(ShowLoadingBeaconSettingEvent());
    await _updateBeaconInformationUseCase
        .call(BeaconInformation(
      identifier: identifier,
      uuid: uuid,
      major: int.parse(major),
      minor: int.parse(minor),
    ))
        .onFailure((e) {
      triggerEvent(ShowToastBeaconSettingEvent("비콘정보 업데이트에 실패했습니다.\n재시도해주세요."));
    });

    triggerEvent(CloseLoadingBeaconSettingEvent());
    triggerEvent(ShowToastBeaconSettingEvent("비콘정보가 수정되었습니다."));
  }
}
