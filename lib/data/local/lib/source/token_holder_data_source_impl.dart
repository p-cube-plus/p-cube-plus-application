import 'package:data/source/local/token_holder_data_source.dart';
import 'package:local/utils/secure_storage/secure_storage_util.dart';

class TokenHolderDataSourceImpl implements TokenHolderDataSource {
  final util = SecureStorageUtil();

  @override
  Future<bool> isExistToken() async {
    return (await util.getAccessToken()) != null;
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) async {
    util.saveAccessToken(accessToken);
    util.saveRefreshToken(refreshToken);
  }

  @override
  Future<void> deleteToken() async {
    util.deleteAccessToken();
    util.deleteRefreshToken();
  }
}
