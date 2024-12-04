import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_position_type.dart';

class MemberFilterContent {}

class MemberFilterType {
  final List<MemberPartType> availablePartTypeList;
  final List<MemberPositionType> availablePositionTypeList;

  MemberFilterType(
    this.availablePartTypeList,
    this.availablePositionTypeList,
  );
}

enum MemberSortType {
  name(SortType.ascend),
  member(SortType.ascend),
  grade(SortType.ascend),
  ;

  final SortType type;
  const MemberSortType(this.type);
}

enum SortType {
  ascend,
  descend,
}
