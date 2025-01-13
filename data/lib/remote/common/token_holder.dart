import 'package:data/local/secure_storage/secure_storage_local_datasource.dart';
import 'package:get_it/get_it.dart';

mixin class TokenHolder {
  String _accessToken = "";
  String _refreshToken = "";

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  final secureStorageLocalDatasource =
      GetIt.I.get<SecureStorageLocalDatasource>();

  Future<void> setToken(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    await Future.wait([
      secureStorageLocalDatasource.saveAccessToken(accessToken),
      secureStorageLocalDatasource.saveRefreshToken(refreshToken),
    ]);
  }
}
