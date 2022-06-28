import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/caution.dart';

class UserDataProvider with ChangeNotifier {
  bool _isLoaded = false;

  User? _user;
  User? get user => _user;
  double get totalCaution {
    double ret = 0;
    for (int i = 0; i < (_user?.cautions.length ?? 0); i++) {
      ret += _user!.cautions[i].type;
    }

    return ret * 0.5;
  }

  UserDataProvider() {
    initialize();
  }

  Future initialize() async {
    _user = await _getData();
    _isLoaded = true;

    notifyListeners();
  }

  Future<User> _getData() async {
    User user = User(
      name: "조승빈",
      profile:
          null, //"https://cdn.discordapp.com/avatars/264788350227972097/ba95f75e90872ba95c65f1d89f7f0148.webp",
      partIndex: 1,
      projects: <String>["PCube+"],
      cautions: <Caution>[
        Caution(
          type: 2,
          description: "경고 부여 1",
          date: DateTime(2022, 05, 27),
        ),
        Caution(
          type: 1,
          description: "주의 부여 1",
          date: DateTime(2022, 05, 27),
        )
      ],
      seminars: <int>[],
    );
    String js = jsonEncode(user.toJson());
    Map<String, dynamic> json = jsonDecode(js);

    return User.fromJson(json);
  }

  void update() async {
    if (!_isLoaded) return;

    // 데이터 갱신
    _user = await _getData();
    notifyListeners();
  }
}
