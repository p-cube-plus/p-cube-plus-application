import 'package:meta/meta.dart';

@immutable
class MemberSelection {
  final String name;
  final int grade;
  const MemberSelection({
    required this.name,
    required this.grade,
  });
}
