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

  final mockNotification = List.generate(25, (index) {
    return NotificationData(
      id: index,
      type: RegularMettingNotification(),
      date: DateTime.now(),
      title: "Title 예시 $index",
      description: "알림 설명설명설명설명설명",
      isRead: MockUtil().getRandomBool(),
    );
  });

  @override
  Future<List<NotificationData>> getNotificationList() async {
    await MockUtil().applyMockSetting();

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
    await MockUtil().applyMockSetting();

    return NotificationSetting(
      type: type,
      isOn: true,
      reminderHours: 2,
    );
  }

  @override
  Future<NotificationData> updateNotificationAsRead(int id) async {
    await MockUtil().applyMockSetting();

    final index = mockNotification.indexWhere((data) => data.id == id);

    if (index != -1) {
      final target = mockNotification[index];
      mockNotification[index] = NotificationData(
        id: target.id,
        type: target.type,
        date: target.date,
        title: target.title,
        description: target.description,
        isRead: true,
      );
      return mockNotification[index];
    }

    throw Exception("삭제할 알림을 찾지 못했습니다.");
  }
}
