import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/utils/mock_util.dart';
import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:domain/notification/value_objects/regular_notification_data.dart';
import 'package:domain/notification/value_objects/regular_notification_setting.dart';
import 'package:get_it/get_it.dart';

class MockNotificationRepositoryImpl implements NotificationRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();

  final mockNotification = List.generate(50, (index) {
    return NotificationData(
      id: index,
      type: RegularMettingNotification(),
      date: DateTime.now(),
      title: "Title 예시",
      description: "알림 설명설명설명설명설명",
      isRead: MockUtil().getRandomBool(),
    );
  });

  @override
  Future<List<NotificationData>> getNotificationList() {
    return Future.value(mockNotification);
  }

  @override
  Future<List<RegularNotificationData>> getRegularNotification(
      PartMettingNotification type) {
    // TODO: implement getRegularNotification
    throw UnimplementedError();
  }

  @override
  Future<void> setNotification(
      NotificationType type, bool isEnable, DateTime beforeMeetingTime) {
    // TODO: implement setNotification
    throw UnimplementedError();
  }

  @override
  Future<void> setNotificationAllEnable(bool isEnable) {
    // TODO: implement setNotificationAllEnable
    throw UnimplementedError();
  }

  @override
  Future<void> setNotificationEnable(NotificationType type, bool isEnable) {
    // TODO: implement setNotificationEnable
    throw UnimplementedError();
  }

  @override
  Future<void> setRegularNotification(RegularNotificationSetting setting) {
    // TODO: implement setRegularNotification
    throw UnimplementedError();
  }

  @override
  Future<NotificationSetting> fetchNotificationSetting(
      NotificationType type) async {
    await Future.delayed(Duration(seconds: 1));
    return NotificationSetting(
      type: type,
      isOn: true,
      reminderHours: 2,
    );
  }

  @override
  Future<void> updateNotificationAsRead(int id) async {
    Future.delayed(Duration(seconds: 2));
    // final target = mockNotification.first((data) => data.id == id);
    // target
  }
}
