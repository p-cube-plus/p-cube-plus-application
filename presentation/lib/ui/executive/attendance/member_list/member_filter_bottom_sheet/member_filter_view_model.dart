import 'package:domain/member/usecases/fetch_member_filter_use_case.dart';
import 'package:domain/member/usecases/update_member_filter_use_case.dart';
import 'package:domain/member/value_objects/member_filter.dart';
import 'package:presentation/common/base_viewmodel.dart';

class MemberFilterViewModel extends BaseViewModel<void> {
  final _fetchMemberFilterUseCase = FetchMemberFilterUseCase();
  final _updateMemberFilterUseCase = UpdateMemberFilterUseCase();

  late MemberFilter memberFilter;

  MemberFilterViewModel() {
    memberFilter = _fetchMemberFilterUseCase();
  }

  void onUpdateIsShowOnlyActiveMember(bool isOn) {
    memberFilter = memberFilter.copyWith(
      isShowOnlyActiveMember: isOn,
    );
  }

  void onUpdateMemberNameSortType(SortType sortType) {
    memberFilter = memberFilter.copyWith(
      memberNameSortType: sortType,
    );
  }

  void onSaveFilter() {
    _updateMemberFilterUseCase(memberFilter);
  }
}
