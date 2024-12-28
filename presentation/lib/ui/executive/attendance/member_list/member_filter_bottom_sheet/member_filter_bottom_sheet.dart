import 'package:domain/member/value_objects/member_filter.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/ui/executive/attendance/member_list/member_filter_bottom_sheet/member_filter_view_model.dart';
import 'package:presentation/widgets/defauilt_toggle_tile.dart';
import 'package:presentation/widgets/sort_sliding_toggle_button.dart';
import 'package:provider/provider.dart';

class MemberFilterBottomSheet extends StatelessWidget {
  final void Function(MemberFilter filter) onSetFilter;
  const MemberFilterBottomSheet({super.key, required this.onSetFilter});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemberFilterViewModel(),
      child: _MemberFilterBottomSheet(onSetFilter),
    );
  }
}

class _MemberFilterBottomSheet extends StatelessWidget
    with ViewModel<MemberFilterViewModel> {
  final void Function(MemberFilter filter) onSetFilter;
  const _MemberFilterBottomSheet(this.onSetFilter);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 32),
          child: Text(
            "필터",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "회원 분류",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        DefaultToggleTile(
          title: "활동 회원만 보기",
          hasShadow: false,
          value: read(context).memberFilter.isShowOnlyActiveMember,
          background: theme.background,
          onChanged: (isOn) {
            read(context).onUpdateIsShowOnlyActiveMember(isOn);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 24),
          child: Text(
            "이름 정렬",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        SortSlidingToggleButton(
          onToggle: (SortType sortType) =>
              read(context).onUpdateMemberNameSortType(sortType),
          initializeValue: read(context).memberFilter.memberNameSortType,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: ElevatedButton(
            onPressed: () {
              read(context).onSaveFilter();
              onSetFilter(read(context).memberFilter);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "필터 적용하기",
                  textAlign: TextAlign.center,
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
      ],
    );
  }
}
