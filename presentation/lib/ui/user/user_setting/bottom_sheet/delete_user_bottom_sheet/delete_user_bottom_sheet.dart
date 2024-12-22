import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/user/user_delete_complete/user_delete_complete_page.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/delete_user_bottom_sheet/delete_user_bottom_sheet_event.dart';
import 'package:presentation/ui/user/user_setting/bottom_sheet/delete_user_bottom_sheet/delete_user_bottom_sheet_view_model.dart';
import 'package:presentation/widgets/status_icon/status_check.dart';
import 'package:provider/provider.dart';

class DeleteUserBottomSheet extends StatelessWidget {
  const DeleteUserBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeleteUserBottomSheetViewModel(),
      child: _DeleteUserBottomSheet(),
    );
  }
}

class _DeleteUserBottomSheet extends StatefulWidget {
  @override
  State<_DeleteUserBottomSheet> createState() => _DeleteUserBottomSheetState();
}

class _DeleteUserBottomSheetState extends State<_DeleteUserBottomSheet>
    with ViewModel<DeleteUserBottomSheetViewModel> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _setEventListener());
  }

  void _setEventListener() {
    read(context).uiEventStream.listen((event) {
      switch (event) {
        case OnSuccessDeleteUserEvent():
          _navigateToDeleteUserCompletePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "회원탈퇴",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "탈퇴하시면 PCube+ 서비스에 대한 모든 데이터가 삭제됩니다.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.neutral40,
            ),
          ),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              read(context).onChangeSelected();
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  watchWidget(
                    (viewModel) => viewModel.isSelected,
                    (context, isSelected) {
                      return StatusCheck(isChecked: isSelected, size: 20);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    "PCube+ 서비스를 탈퇴하겠습니다.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.neutral80,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          watchWidget(
            (viewModel) => viewModel.isSelected,
            (context, isSelected) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 32),
                child: ElevatedButton(
                  onPressed: read(context).onPressedDeleteUserButton(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "탈퇴하기",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToDeleteUserCompletePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => UserDeleteCompletePage(),
      ),
      (route) => false,
    );
  }
}
