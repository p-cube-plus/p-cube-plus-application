import '../models/user.dart';
import 'base/pcube_api.dart';

class UserProfileApi extends PCubeApi {
  UserProfileApi() : super(endPoint: "/user/profile");

  @override
  Future<User?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super
        .get(decodeFunction: (jsonDecodeData) => User.fromJson(jsonDecodeData));
  }
}
