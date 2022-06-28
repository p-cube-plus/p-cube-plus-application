import 'caution.dart';

class User {
  final String name;
  final String? profile;
  final int partIndex;
  final List<String> projects;
  final List<Caution> cautions;
  final List<int> seminars;

  User({
    required this.name,
    required this.profile,
    required this.partIndex,
    required this.projects,
    required this.cautions,
    required this.seminars,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profile: json['profile'],
      partIndex: json['partIndex'],
      projects: (json['projects'] as List<dynamic>)
          .map<String>((e) => e.toString())
          .toList(),
      cautions: (json['cautions'] as List<dynamic>)
          .map<Caution>((e) => Caution.fromJson(e))
          .toList(),
      seminars: (json['seminars'] as List<dynamic>)
          .map<int>((e) => int.parse(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'profile': profile,
        'partIndex': partIndex,
        'projects': projects,
        'cautions': cautions,
        'seminars': seminars,
      };
}
