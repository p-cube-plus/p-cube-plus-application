import 'package:domain/models/notification/notification_data.dart';
import 'package:domain/models/user/user_profile_data.dart';
import 'package:domain/models/user/user_project_data.dart';
import 'package:domain/models/user/user_warning_data.dart';

abstract class UserService {
  Future<List<NotificationData>> getNotificationList();
  Future<UserProfileData> getUserProfile();
  Future<List<UserProjectData>> getUserProject();
  Future<UserWarningData> getUserWarning();
  Future<UserWarningData> getCurrentUserWarning();
}
