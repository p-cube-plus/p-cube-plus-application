import 'package:domain/notification/models/notification_data.dart';
import 'package:domain/user/models/user_profile_data.dart';
import 'package:domain/user/models/user_project_data.dart';
import 'package:domain/user/models/user_warning_data.dart';

abstract interface class UserRepository {
  Future<List<NotificationData>> getNotificationList();
  Future<UserProfileData> getUserProfile();
  Future<List<UserProjectData>> getUserProject();
  Future<UserWarningData> getUserWarning();
  Future<UserWarningData> getCurrentUserWarning();
}
