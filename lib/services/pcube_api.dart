import 'package:http/http.dart' as http;

const String _baseUrl = "http://p-cube-plus.com";

abstract class PCubeApi {
  final String endPoint;

  PCubeApi({required this.endPoint});

  Future<http.Response> send({Map<String, String>? headers}) async {
    var response = await http.get(
      Uri.parse(_baseUrl + endPoint),
      headers: headers,
    );

    return response;
  }
}


/*
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/user.dart';

part 'pcube_api.g.dart';

@RestApi(baseUrl: "http://p-cube-plus.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/user/profile")
  Future<User> getUser();
}
*/