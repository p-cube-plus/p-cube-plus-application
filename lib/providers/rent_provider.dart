import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/models/product.dart';
import 'dart:async';
import '../services/rent_api.dart';
import '../models/rent.dart';

class RentProvider with ChangeNotifier {
  RentListApi _client = new RentListApi();
  List<Rent> _rentList = [];

  Future<List<Rent>>? searchRentList(String name) async {
    return _rentList
        .where((element) => element.product.name.contains(name))
        .toList();
  }

  Future<List<Rent>> update({int? count}) async {
    //_rentList = (await _client.get()) ?? [];
    _rentList = await _getDummy();
    notifyListeners();
    return count == null ? _rentList : _rentList;
  }

  List<Rent> _getDummy() {
    return <Rent>[
      Rent(
          product: Product(
              code: 0,
              isAvailable: true,
              name: "판도라큐브의 은밀한 물품",
              category: "책",
              location: "123-123",
              detailLocation: "456-789",
              modelName: null,
              status: ProductStatus(value: "0", rentUser: "권오민")),
          deadline: DateTime(2024, 12, 12),
          rentDay: DateTime(2022, 04, 04),
          dDay:
              DateTime(2024, 12, 12).difference(DateTime(2022, 04, 04)).inDays,
          returnDay: null),
      Rent(
          product: Product(
              code: 0,
              isAvailable: true,
              name: "운영체제 족보",
              category: "책",
              location: "123-123",
              detailLocation: "456-789",
              modelName: null,
              status: ProductStatus(value: "0", rentUser: "권오민")),
          deadline: DateTime(2024, 12, 12),
          rentDay: DateTime(2023, 09, 12),
          dDay:
              DateTime(2024, 12, 12).difference(DateTime(2023, 09, 12)).inDays,
          returnDay: null),
      Rent(
          product: Product(
              code: 0,
              isAvailable: true,
              name: "Clean Code",
              category: "책",
              location: "123-123",
              detailLocation: "456-789",
              modelName: null,
              status: ProductStatus(value: "0", rentUser: "권오민")),
          deadline: DateTime(2024, 12, 12),
          rentDay: DateTime(2023, 08, 21),
          dDay:
              DateTime(2024, 12, 12).difference(DateTime(2023, 08, 21)).inDays,
          returnDay: null),
    ];
  }
}
