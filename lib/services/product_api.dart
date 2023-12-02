import 'dart:convert';

import '../models/rent.dart';
import 'base/pcube_api.dart';

class ProductListApi extends PCubeApi {
  ProductListApi() : super(endPoint: "/product/list");

  @override
  Future<List<Rent>> get({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async =>
      await super.get(
          successReturnFunction: (body) => (jsonDecode(body) as List)
              .map((data) => Rent.fromJson(data))
              .toList());
}
