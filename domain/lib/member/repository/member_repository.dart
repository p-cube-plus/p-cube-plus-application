import 'package:domain/member/value_objects/developer_member.dart';
import 'package:domain/member/value_objects/member_selection.dart';

abstract interface class MemberRepository {
  Future<List<DeveloperMember>> getDeveloperList();
  Future<List<MemberSelection>> getAllMemberList();
}
