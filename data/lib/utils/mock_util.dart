import 'dart:math';

import 'package:domain/common/exception/mock_exception.dart';

class MockUtil {
  MockUtil._internal();
  static final MockUtil _instance = MockUtil._internal();
  factory MockUtil() => _instance;
  final _random = Random.secure();

  Future<void> throwMockException() {
    Future.value(throw MockException());
  }

  int getRandomNumber(int start, int end) {
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

  T getRandomEnum<T>(List<T> values, {List<T> except = const []}) {
    List<T> filteredValues =
        values.where((value) => !except.contains(value)).toList();
    int randomIndex = _random.nextInt(filteredValues.length);
    return filteredValues[randomIndex];
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
    int startMillis = start.millisecondsSinceEpoch;
    int endMillis = end.millisecondsSinceEpoch;
    int randomMillis = startMillis + _random.nextInt(endMillis - startMillis);
    return DateTime.fromMillisecondsSinceEpoch(randomMillis);
  }
}
