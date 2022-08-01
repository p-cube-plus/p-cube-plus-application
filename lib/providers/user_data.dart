import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/curriculum.dart';
import 'package:p_cube_plus_application/models/member.dart';
import '../models/promotion_progress.dart';
import '../models/project.dart';
import '../models/seminar.dart';
import '../models/user.dart';
import '../models/caution.dart';
import '../services/pcube_api.dart';
import '../services/user_profile_api.dart';

class UserDataProvider with ChangeNotifier {
  late UserProfileApi _client;
  bool isLoaded = false;

  User? _user;
  User? get user => _user;

  // mode = 0(전체), 1(주의), 2(경고)
  double totalCaution(int mode) {
    double ret = 0;
    for (int i = 0; i < (_user?.cautions.length ?? 0); i++) {
      if (mode != 0 && _user!.cautions[i].type.abs() != mode) continue;
      ret += _user!.cautions[i].type * _user!.cautions[i].amount;
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
    _client = UserProfileApi();
    User? user = await _client.getUser();

    if (user == null) {
      String js = jsonEncode(tempUser().toJson());
      Map<String, dynamic> json = jsonDecode(js);
      user = User.fromJson(json);
    }

    return user;
  }

  User tempUser() => User(
        id: 3,
        level: "정회원",
        name: "조승빈",
        profileImage:
            null, //"https://cdn.discordapp.com/avatars/264788350227972097/ba95f75e90872ba95c65f1d89f7f0148.webp",
        partIndex: 1,
        projects: <Project>[
          Project(
            id: 0,
            type: 0,
            name: "PCube+",
            isEnd: false,
            startDate: DateTime(2022, 05, 27),
            endDate: DateTime(2023, 01, 31),
            members: <Member>[
              Member(id: 0, name: "오창한", partIndex: 1),
              Member(id: 1, name: "권오민", partIndex: 1),
              Member(id: 2, name: "신혜민", partIndex: 0),
              Member(id: 3, name: "조승빈", partIndex: 1),
            ],
            pm: Member(id: 0, name: "오창한", partIndex: 1),
            platforms: <String>[],
            tags: <String>[],
          ),
        ],
        cautions: <Caution>[
          Caution(
            id: 0,
            type: 2,
            amount: 1,
            description: "경고 부여 사유~~~~",
            date: DateTime(2022, 05, 27),
          ),
          Caution(
            id: 1,
            type: 1,
            amount: 1,
            description: "주의 부여 사유~~",
            date: DateTime(2022, 05, 27),
          )
        ],
        seminars: <Seminar>[
          Seminar(
            id: 3,
            type: 0,
            description: "",
            date: DateTime(2020, 05, 27),
          ),
          Seminar(
            id: 4,
            type: 1,
            description: "",
            date: DateTime(2021, 05, 28),
          ),
          Seminar(
            id: 5,
            type: 2,
            description: "",
            date: DateTime(2022, 05, 29),
          ),
        ],
        promotionProgress: PromotionProgress(
          semester: false,
          curriculum: Curriculum(
            completed: false,
            name: "유니티 커리큘럼",
            startDate: DateTime(2022, 07, 16),
            endDate: DateTime(2022, 08, 05),
          ),
          progress: 0.6,
          projectAttended: false,
          projectType: 1,
          workshopComplete: true,
          workshopCount: 2,
          vote: false,
        ),
      );

  void update() async {
    if (!isLoaded) return;

    // 데이터 갱신
    _user = await _getData();
    notifyListeners();
  }
}
