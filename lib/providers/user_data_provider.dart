import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/curriculum.dart';
import 'package:p_cube_plus_application/models/member.dart';
import 'package:p_cube_plus_application/models/user/user_profile.dart';
import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/models/user/user_warning.dart';
import '../models/promotion_progress.dart';
import '../models/project.dart';
import '../models/seminar.dart';
import '../models/caution.dart';
import '../services/user_api.dart';

class UserDataProvider with ChangeNotifier {
  UserProfileApi _profileApi = new UserProfileApi();
  UserProjectApi _projectApi = new UserProjectApi();
  UserWarningApi _warningApi = new UserWarningApi();

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
