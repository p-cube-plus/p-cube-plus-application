import 'package:domain/member/repository/member_repository.dart';
import 'package:domain/member/value_objects/member_filter.dart';
import 'package:get_it/get_it.dart';

class UpdateMemberFilterUseCase {
  final _memberRepository = GetIt.I.get<MemberRepository>();

  void call(MemberFilter newFilter) {
    _memberRepository.updateMemberFilter(newFilter);
  }
}
