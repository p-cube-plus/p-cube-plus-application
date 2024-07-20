import 'package:data/models/remote/notification/notification_dto.dart';
import 'package:data/models/remote/user/user_profile_dto.dart';
import 'package:data/models/remote/user/user_project_dto.dart';
import 'package:data/models/remote/user/user_warning_dto.dart';

abstract class UserService {
  Future<List<NotificationDTO>> getNotificationList();
  Future<UserProfileDTO> getUserProfile();
  Future<List<UserProjectDTO>> getUserProject();
  Future<UserWarningDTO> get();
}
