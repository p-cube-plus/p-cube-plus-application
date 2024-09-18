import 'package:data/remote/p_cube_api/p_cube_api.dart';

class AuthRemoteDatasource {
  Future<void> deleteToken() async {
    await PCubeApi().delete("/auth/logout");
  }
}
