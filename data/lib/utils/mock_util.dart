import 'dart:math';

import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:domain/common/exception/app_timeout_exception.dart';
import 'package:domain/common/exception/mock_exception.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:get_it/get_it.dart';

class MockUtil {
  MockUtil._internal();
  static final MockUtil _instance = MockUtil._internal();
  factory MockUtil() => _instance;

  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();

  final _random = Random.secure();

  Future<void> throwMockException() {
    Future.value(throw MockException());
  }

  int getRandomNumber(int start, int end) {
    if (end - start >= 1 << 31) {
      return start + _random.nextInt(1 << 31 - 1);
    }
    return start + _random.nextInt(end - start + 1);
  }

  double getRandomDouble(double start, double end, double interval) {
    int factor = (1 / interval).toInt();
    int startScaled = (start * factor).toInt();
    int endScaled = (end * factor).toInt();

    int randomInt = startScaled + _random.nextInt(endScaled - startScaled + 1);
    return randomInt / factor;
  }

  Duration getRandomDuration(int startMillis, int endMillis) {
    final randomMillis = getRandomNumber(startMillis, endMillis);
    return Duration(milliseconds: randomMillis);
  }

  bool getRandomBool() {
    return _random.nextBool();
  }

  T getRandom<T>(List<T> values, {List<T> except = const []}) {
    List<T> filteredValues =
        values.where((value) => !except.contains(value)).toList();
    int randomIndex = _random.nextInt(filteredValues.length);
    return filteredValues[randomIndex];
  }

  MemberType getRandomMemberType() {
    final targetValues = [
      TraineeMember(),
      RegularMember(),
      DormantMember(),
      GraduateMember(),
    ];
    int randomIndex = _random.nextInt(targetValues.length);
    return targetValues[randomIndex];
  }

  String getRandomKoreanName() {
    final sample =
        "가강고곽구권기김나남노당대도마명모문미박방배백변사서선설섭성소손송수시신양여엄영오옥우유류윤이임장전정조주지창최민태추최표하한허호황";

    final first = getRandomNumber(0, sample.length - 1);
    final second = getRandomNumber(0, sample.length - 1);
    final last = getRandomNumber(0, sample.length - 1);

    return sample[first] + sample[second] + sample[last];
  }

  DateTime getRandomDateTime(DateTime start, DateTime end) {
    int startSeconds = start.millisecondsSinceEpoch ~/ 1000;
    int endSeconds = end.millisecondsSinceEpoch ~/ 1000;
    int randomSeconds = getRandomNumber(startSeconds, endSeconds);
    return DateTime.fromMillisecondsSinceEpoch(randomSeconds * 1000);
  }

  Future applyMockSetting() async {
    try {
      final delay = (sharedPreferenceLocalDatasource.mockDelay * 1000).toInt();
      await Future.delayed(Duration(milliseconds: delay))
          .timeout(PCubeApi().timeout);
    } catch (e) {
      throw AppTimeoutException();
    }

    if (sharedPreferenceLocalDatasource.isTestingException) {
      throw MockException();
    }
  }
}
