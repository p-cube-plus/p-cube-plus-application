import 'curriculum.dart';
import 'caution.dart';
import 'project.dart';
import 'seminar.dart';

class User {
  final String name;
  final String? profile;
  final int partIndex;
  final List<Project> projects;
  final List<Caution> cautions;
  final List<Seminar> seminars;
  final Curriculum curriculum;

  User({
    required this.name,
    required this.profile,
    required this.partIndex,
    required this.projects,
    required this.cautions,
    required this.seminars,
    required this.curriculum,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profile: json['profile'],
      partIndex: json['partIndex'],
      projects: (json['projects'] as List<dynamic>)
          .map<Project>((e) => Project.fromJson(e))
          .toList(),
      cautions: (json['cautions'] as List<dynamic>)
          .map<Caution>((e) => Caution.fromJson(e))
          .toList(),
      seminars: (json['seminars'] as List<dynamic>)
          .map<Seminar>((e) => Seminar.fromJson(e))
          .toList(),
      curriculum: Curriculum.fromJson(json['curriculum']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'profile': profile,
        'partIndex': partIndex,
        'projects': projects,
        'cautions': cautions,
        'seminars': seminars,
        'curriculum': curriculum,
      };
}
