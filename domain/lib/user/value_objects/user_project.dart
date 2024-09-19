import 'package:meta/meta.dart';

@immutable
class UserProject {
  final String title;
  final String projectType;
  const UserProject({
    required this.title,
    required this.projectType,
  });
}
