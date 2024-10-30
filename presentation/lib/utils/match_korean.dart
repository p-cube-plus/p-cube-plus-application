class Korean {
  final String completedKorean;
  final List<String> _splitedKorean;

  String get initialConsonant => _splitedKorean[0];
  String get medialVowel => _splitedKorean[1];
  String get finalConsonant => _splitedKorean[2];

  Korean(String char)
      : completedKorean = char,
        _splitedKorean = _splitKorean(char);

  static const String initialList = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
  static const String medialList = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ";
  static const String finalList = " ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ";

  static List<String> _splitKorean(String char) {
    int unicode = char.codeUnitAt(0);
    if (0xAC00 <= unicode && unicode <= 0xD7A3) {
      int base = unicode - 0xAC00;
      int initialIndex = base ~/ (21 * 28);
      int medialIndex = (base % (21 * 28)) ~/ 28;
      int finalIndex = base % 28;

      return [
        initialList[initialIndex],
        medialList[medialIndex],
        finalIndex == 0 ? "" : finalList[finalIndex]
      ];
    }
    return [char, "", ""];
  }

  @override
  String toString() => completedKorean;

  @override
  bool operator ==(covariant Korean other) {
    return completedKorean == other.completedKorean;
  }

  @override
  int get hashCode => completedKorean.hashCode;
}

extension KoreanStringExtension on String {
  bool matchKorean(String query) {
    if (query.isEmpty) return true;

    List<Korean> queryParts =
        query.split('').map((char) => Korean(char)).toList();

    int queryIndex = 0;

    final sourceKoreanParts = split('').map((char) => Korean(char)).toList();

    for (int sourceIndex = 0;
        sourceIndex < sourceKoreanParts.length;
        sourceIndex++) {
      if (sourceKoreanParts[sourceIndex].initialConsonant ==
          queryParts[queryIndex].initialConsonant) {
        if (queryParts[queryIndex].medialVowel.isNotEmpty &&
            queryParts[queryIndex].medialVowel !=
                sourceKoreanParts[sourceIndex].medialVowel) {
          continue;
        }
        if (queryParts[queryIndex].finalConsonant.isNotEmpty &&
            queryParts[queryIndex].finalConsonant !=
                sourceKoreanParts[sourceIndex].finalConsonant) {
          continue;
        }

        queryIndex++;

        if (queryIndex == queryParts.length) {
          return true;
        }
      } else {
        queryIndex = 0;
      }
    }

    return false;
  }
}
