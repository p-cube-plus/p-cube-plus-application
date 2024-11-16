import 'package:domain/project/value_objects/project_type.dart';
import 'package:meta/meta.dart';

@immutable
class UserProject {
  final String title;
  final ProjectType projectType;
  const UserProject({
    required this.title,
    required this.projectType,
  });
}
