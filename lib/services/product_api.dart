import 'dart:convert';

import '../models/rent.dart';
import 'base/pcube_api.dart';
import 'package:http/http.dart' as http;

class ProductListApi extends PCubeApi {
  ProductListApi() : super(endPoint: "/product/list");

  @override
  Future<List<Rent>> get({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async =>
      await super.get(
        successReturnFunction: (response) => (jsonDecode(response.body) as List)
            .map((data) => Rent.fromJson(data))
            .toList(),
        additionalHeader: additionalHeader,
        queryParams: queryParams,
      );
}
