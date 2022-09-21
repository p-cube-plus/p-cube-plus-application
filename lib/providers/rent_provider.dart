import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/rent_api.dart';
import '../models/rent.dart';

class RentProvider with ChangeNotifier {
  late RentListApi _client;

  bool loaded = false;
  bool fail = false;

  late List<Rent>? _rentList;
  List<Rent>? get rentList => loaded ? _rentList : null;

  RentProvider() {
    initialize();
  }

  void initialize() {
    update();
  }

  Future<List<Rent>?> _getRents() async {
    _client = RentListApi();
    List<Rent>? _rentList = await _client.getRentList();

    //_client = RentListApi(id: 1);
    //Rent? _rent = await _client.getRentInformation();
    //print(_rent!.toJson().toString());

    return _rentList;
  }

  Rent? getRent({int? id, int? index}) {
    if (!loaded) return null;
    if (id == null && index == null) return null;
    if (index != null) return _rentList![index];

    var rents = _rentList!.where((e) => e.id == id);

    return rents.isEmpty ? null : rents.first;
  }

  void update() async {
    // 데이터 갱신
    _rentList = await _getRents();

    fail = _rentList == null;
    loaded = true;

    //print(getRent(id: 1)!.toJson());

    notifyListeners();
  }
}
