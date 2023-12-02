import 'package:p_cube_plus_application/models/caution.dart';
import 'package:p_cube_plus_application/models/curriculum.dart';
import 'package:p_cube_plus_application/models/member.dart';
import 'package:p_cube_plus_application/models/project.dart';
import 'package:p_cube_plus_application/models/promotion_progress.dart';
import 'package:p_cube_plus_application/models/seminar.dart';
import 'package:p_cube_plus_application/models/user.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserDataProvider extends ApiProviderBase<User> {
  UserDataProvider() : super(client: new UserProfileApi());

  UserProfile? _profile;
  UserProfile? get profile => _profile;
  List<UserProject>? _project;
  List<UserProject>? get project => _project;
  UserWarning? _warning;
  UserWarning? get warning => _warning;

  Future<UserProfile?> updateProfile() async {
    _profile = await _profileApi.getProfileInfo();
    notifyListeners();
    return _profile;
  }

  // mode = 0(경고), 1(주의)
  double totalCaution(int type, {int sign = 1}) {
    double ret = 0;
  Future<List<UserProject>?> updateProject() async {
    _project = await _projectApi.getProjectInfo();
    notifyListeners();
    return _project;
  }

  Future<UserWarning?> updateWarning() async {
    _warning = await _warningApi.getWarningInfo();
    notifyListeners();
    return _warning;
  }
}
