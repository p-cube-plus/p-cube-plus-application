import 'package:domain/member/value_objects/developer_member.dart';
import 'package:domain/member/value_objects/member_filter.dart';
import 'package:domain/member/value_objects/member_selection.dart';

abstract interface class MemberRepository {
  List<DeveloperMember> getDeveloperList();
  Future<List<MemberSelection>> getAllMemberList();
  MemberFilter getMemberFilter();
  void updateMemberFilter(MemberFilter filter);
}
