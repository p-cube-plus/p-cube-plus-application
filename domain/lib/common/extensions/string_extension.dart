extension StringExtension on String {
  DateTime toDateTime(String format) {
    int year = 0, month = 1, day = 1, hour = 0, minute = 0, second = 0;
    final formatMap = {
      'yyyy': (String s) => year = int.parse(s),
      'MM': (String s) => month = int.parse(s),
      'M': (String s) => month = int.parse(s),
      'dd': (String s) => day = int.parse(s),
      'd': (String s) => day = int.parse(s),
      'HH': (String s) => hour = int.parse(s),
      'H': (String s) => hour = int.parse(s),
      'hh': (String s) => hour = int.parse(s),
      'h': (String s) => hour = int.parse(s),
      'mm': (String s) => minute = int.parse(s),
      'm': (String s) => minute = int.parse(s),
      'ss': (String s) => second = int.parse(s),
      's': (String s) => second = int.parse(s),
    };

    int i = 0;
    while (i < format.length) {
      for (var key in formatMap.keys) {
        if (format.startsWith(key, i)) {
          var length = key.length;
          formatMap[key]!(substring(i, i + length));
          i += length;
          break;
        }
      }
      if (i < format.length &&
          !formatMap.keys.any((key) => format.startsWith(key, i))) {
        i++;
      }
    }

    return DateTime(year, month, day, hour, minute, second);
  }
}
