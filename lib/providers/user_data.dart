import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/curriculum.dart';
import '../models/project.dart';
import '../models/seminar.dart';
import '../models/user.dart';
import '../models/caution.dart';

/*
의문점

User 정보 프로바이더 이대로 모든 데이터를 한 Provider가 관리하는게 나을까
아니면 정보마다 다른 Provider를 사용하는게 나을까
 ex) 경고 Provider, 커리큘럼 Provider 등등..
*/

class UserDataProvider with ChangeNotifier {
  bool isLoaded = false;

  User? _user;
  User? get user => _user;

  // mode = 0(전체), 1(주의), 2(경고)
  double totalCaution(int mode) {
    double ret = 0;
    for (int i = 0; i < (_user?.cautions.length ?? 0); i++) {
      if (mode != 0 && _user!.cautions[i].type.abs() != mode) continue;
      ret += _user!.cautions[i].type * _user!.cautions[i].count;
    }

    if (mode == 0) return ret / 2.0;
    return ret / mode;
  }

  UserDataProvider() {
    initialize();
  }

  Future initialize() async {
    _user = await _getData();
    isLoaded = true;

    notifyListeners();
  }

  Future<User> _getData() async {
    String js = jsonEncode(tempUser().toJson());
    Map<String, dynamic> json = jsonDecode(js);
    print(js);

    return User.fromJson(json);
  }

  User tempUser() => User(
        name: "조승빈",
        profile:
            null, //"https://cdn.discordapp.com/avatars/264788350227972097/ba95f75e90872ba95c65f1d89f7f0148.webp",
        partIndex: 1,
        projects: <Project>[
          Project(
            type: 0,
            name: "PCube+",
            isEnd: false,
            begin: DateTime(2022, 05, 27),
            members: <String>[
              "오창한",
              "조승빈",
              "권오민",
              "신혜민",
            ],
          ),
        ],
        cautions: <Caution>[
          Caution(
            type: 2,
            count: 1,
            description: "경고 부여 사유~~~~",
            date: DateTime(2022, 05, 27),
          ),
          Caution(
            type: 1,
            count: 1,
            description: "주의 부여 사유~~",
            date: DateTime(2022, 05, 27),
          )
        ],
        seminars: <Seminar>[
          Seminar(
            type: 0,
            description: "",
            date: DateTime(2020, 05, 27),
          ),
          Seminar(
            type: 1,
            description: "",
            date: DateTime(2021, 05, 28),
          ),
          Seminar(
            type: 2,
            description: "",
            date: DateTime(2022, 05, 29),
          ),
        ],
        curriculum: Curriculum(
          curriculumComplete: false,
          curriculumDescription: "커리큘럼 이름",
          period: 1,
          progress: 0.5,
          projectCount: 1,
          vote: false,
          workshopCount: 2,
        ),
      );

  void update() async {
    if (!isLoaded) return;

    // 데이터 갱신
    _user = await _getData();
    notifyListeners();
  }
}
