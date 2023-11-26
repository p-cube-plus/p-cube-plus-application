import '../models/user.dart';
import 'base/pcube_api.dart';

class UserProfileApi extends PCubeApi {
  UserProfileApi() : super(endPoint: "/user/profile");

  @override
  Future<User?> get({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    return await super.get(
        successReturnFunction: (jsonDecodeData) =>
            User.fromJson(jsonDecodeData));
  }
}
