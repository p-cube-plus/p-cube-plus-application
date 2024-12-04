import 'package:meta/meta.dart';

@immutable
class MemberFilter {
  final bool isShowOnlyActiveMember;
  final SortType memberNameSortType;
  const MemberFilter({
    required this.isShowOnlyActiveMember,
    required this.memberNameSortType,
  });

  MemberFilter copyWith({
    bool? isShowOnlyActiveMember,
    SortType? memberNameSortType,
  }) {
    return MemberFilter(
      isShowOnlyActiveMember:
          isShowOnlyActiveMember ?? this.isShowOnlyActiveMember,
      memberNameSortType: memberNameSortType ?? this.memberNameSortType,
    );
  }
}

enum SortType {
  ascend,
  descend,
}
