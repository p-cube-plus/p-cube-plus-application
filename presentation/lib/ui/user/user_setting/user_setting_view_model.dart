import 'package:domain/member/usecases/fetch_development_list_use_case.dart';
import 'package:domain/member/value_objects/developer_member.dart';
import 'package:presentation/common/base_viewmodel.dart';

class UserSettingViewModel extends BaseViewModel<void, void> {
  final _fetchDevelopmentListUseCase = FetchDevelopmentListUseCase();

  List<DeveloperMember> fetchDevelopmentList() =>
      _fetchDevelopmentListUseCase.call();
}
