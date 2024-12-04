import 'package:domain/member/repository/member_repository.dart';
import 'package:domain/member/value_objects/developer_member.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:get_it/get_it.dart';

class FetchDevelopmentListUseCase {
  final _memberRepository = GetIt.I.get<MemberRepository>();

  List<DeveloperMember> call() {
    return _memberRepository.getDeveloperList();
  }
}
