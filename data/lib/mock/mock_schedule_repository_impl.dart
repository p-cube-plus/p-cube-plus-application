import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';

class MockScheduleRepositoryImpl implements ScheduleRepository {
  @override
  Future<List<ScheduleData>> getDailyScheduleDetailList(DateTime date) async {
    final result = await _getMockModel();
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = startDate.add(Duration(days: 1));
    return result.where((data) {
      if (data.startDate.isBefore(startDate)) {
        return data.endDate.isAfter(startDate);
      } else {
        return data.startDate.isBetweenDates(startDate, endDate);
      }
    }).toList();
  }

  @override
  Future<List<ScheduleData>> getScheduleListInMonth(int year, int month) async {
    final result = await _getMockModel();
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);
    return result.where((data) {
      if (data.startDate.isBefore(startDate)) {
        return data.endDate.isAfter(startDate);
      } else {
        return data.startDate.isBetweenDates(startDate, endDate);
      }
    }).toList();
  }

  @override
  Future<List<ScheduleData>> getUpcommingScheduleDetailList() async {
    final today = DateTime.now();
    final maxDate = DateTime.now().add(Duration(days: 7));
    final result = await _getMockModel();
    return result
        .where(
          (data) => data.startDate.isBetweenDates(
            today,
            maxDate,
          ),
        )
        .toList();
  }

  Future<List<ScheduleData>> _getMockModel() {
    final today = DateTime.now();
    return Future.value([
      ScheduleData(
        title: '넘겨지는 스케줄',
        type: ScheduleTypMain(),
        startDate: DateTime(today.year, today.month - 1, 28, 9),
        endDate: DateTime(today.year, today.month, 1, 1),
      ),
      ScheduleData(
        title: '매우 빠른 스케줄',
        type: ScheduleTypMain(),
        startDate: DateTime(today.year, today.month, 1, 9),
        endDate: DateTime(today.year, today.month, 1, 12),
      ),
      ScheduleData(
        title: '워크샵 테스트',
        type: ScheduleWorkShop(),
        startDate: DateTime(today.year, today.month, 1, 9),
        endDate: DateTime(today.year, today.month, 3, 18),
      ),
      ScheduleData(
        title: '청소 테스트',
        type: ScheduleTypeClean(),
        startDate: DateTime(today.year, today.month, 1, 11),
        endDate: DateTime(today.year, today.month, 1, 12),
      ),
      ScheduleData(
        title: '청소 테스트2',
        type: ScheduleTypeClean(),
        startDate: DateTime(today.year, today.month, 5, 11),
        endDate: DateTime(today.year, today.month, 5, 12),
      ),
      ScheduleData(
        title: '7일의 행복',
        type: ScheduleTypMain(),
        startDate: DateTime(today.year, today.month, 7, 7),
        endDate: DateTime(today.year, today.month, 7 + 7, 17),
      ),
      ScheduleData(
        title: '28일의 공포',
        type: ScheduleTypMain(),
        startDate: DateTime(today.year, today.month, 28, 1),
        endDate: DateTime(today.year, today.month, 28, 23),
      ),
    ]);
  }
}
