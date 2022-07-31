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
