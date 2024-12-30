import 'package:domain/login/usecases/delete_user_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/delete_user_bottom_sheet/delete_user_bottom_sheet_event.dart';

class DeleteUserBottomSheetViewModel
    extends BaseViewModel<DeleteUserBottomSheetEvent> {
  bool isSelected = false;
  final _deleteUserUseCase = DeleteUserUseCase();

  void onChangeSelected() {
    isSelected = !isSelected;
    notifyListeners();
  }

  void Function()? onPressedDeleteUserButton() {
    if (!isSelected) return null;
    return () {
      _deleteUserUseCase.call().then((_) {
        triggerEvent(OnSuccessDeleteUserEvent());
      });
    };
  }
}
