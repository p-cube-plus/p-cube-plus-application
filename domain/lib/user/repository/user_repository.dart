import 'package:domain/user/value_objects/user_profile.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';

abstract interface class UserRepository {
  Future<UserProfile> getUserProfile();
  Future<UserWarning> getUserCumulativeWarning();
  Future<UserWarningDetail> getUserWarningDetail();
  Future<List<UserProject>> getUserProject();
  Future<List<UserProjectDetail>> getUserProjectDetail();
}
