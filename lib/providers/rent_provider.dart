import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/rent.dart';

class RentProvider with ChangeNotifier {
  bool loaded = false;
  bool fail = false;

  late List<Rent>? _rentList;
  List<Rent>? get rentList => _rentList;

  ScheduleProvider() {
    initialize();
  }

  void initialize() {
    update();
    loaded = true;
  }

  Future<List<Rent>?> _getRents() async {
    //String js = jsonEncode(tempRentList());
    //Map<String, dynamic> json = jsonDecode(js);

    return tempRentList();
  }

  List<Rent> tempRentList() {
    return <Rent>[];
  }

  void update() async {
    if (!loaded) return;

    // 데이터 갱신
    _rentList = await _getRents();
    fail = _rentList == null;

    notifyListeners();
  }
}
