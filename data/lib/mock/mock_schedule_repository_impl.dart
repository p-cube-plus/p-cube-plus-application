import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:domain/schedule/value_objects/schedule_detail.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';

class MockScheduleRepositoryImpl implements ScheduleRepository {
  @override
  Future<List<ScheduleDetail>> getDailyScheduleDetailList(DateTime date) async {
    final result = await _getMockModel();
    return result
        .where(
          (data) => date.isBetweenDates(
            data.schedule.startDate,
            data.schedule.endDate,
          ),
        )
        .toList();
  }

  @override
  Future<List<ScheduleData>> getScheduleListInMonth(int year, int month) async {
    final result = await _getMockModel();
    return result.map((data) => data.schedule).toList();
  }

  @override
  Future<List<ScheduleDetail>> getUpcommingScheduleDetailList() async {
    final today = DateTime.now();
    final maxDate = DateTime.now().add(Duration(days: 7));
    final result = await _getMockModel();
    return result
        .where(
          (data) => data.schedule.startDate.isBetweenDates(
            today,
            maxDate,
          ),
        )
        .toList();
  }

  Future<List<ScheduleDetail>> _getMockModel() {
    final today = DateTime.now();
    return Future.value([
      ScheduleDetail(
        title: '매우 빠른 스케줄',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 1, 9),
          endDate: DateTime(today.year, today.month, 1, 12),
        ),
      ),
      ScheduleDetail(
        title: '3일 연속의 스케줄',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 1, 12),
          endDate: DateTime(today.year, today.month, 3, 18),
        ),
      ),
      ScheduleDetail(
        title: '7일의 행복',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 7, 7, 7, 7),
          endDate: DateTime(today.year, today.month, 7, 17, 7, 7),
        ),
      ),
      ScheduleDetail(
        title: '포키를 먹어라',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 11, 11, 11, 11),
          endDate: DateTime(today.year, today.month, 11, 12),
        ),
      ),
      ScheduleDetail(
        title: '28일의 공포',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 28, 12),
          endDate: DateTime(today.year, today.month, 28, 15),
        ),
      ),
      ScheduleDetail(
        title: '테스트 청소 스케줄',
        schedule: ScheduleData(
          type: ScheduleType.clean,
          startDate: DateTime(today.year, today.month, 15, 15),
          endDate: DateTime(today.year, today.month, 15, 16),
        ),
      ),
      ScheduleDetail(
        title: '테스트 워크샵 스케줄',
        schedule: ScheduleData(
          type: ScheduleType.workshop,
          startDate: DateTime(today.year, today.month, 17, 12),
          endDate: DateTime(today.year, today.month, 20, 12),
        ),
      ),
      ScheduleDetail(
        title: '만약 스케줄이 겹친다면 어쩔테냐',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 15, 17),
          endDate: DateTime(today.year, today.month, 15, 18),
        ),
      ),
      ScheduleDetail(
        title: '그러면 스케줄이 많다면 어쩔테야',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 15, 19),
          endDate: DateTime(today.year, today.month, 15, 20),
        ),
      ),
      ScheduleDetail(
        title: '이어진 스케줄이 먼저냐 새로운 스케줄이 먼저냐',
        schedule: ScheduleData(
          type: ScheduleType.main,
          startDate: DateTime(today.year, today.month, 18, 12),
          endDate: DateTime(today.year, today.month, 18, 13),
        ),
      ),
    ]);
  }
}
