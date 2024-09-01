import 'package:domain/services/firebase_service.dart';
import 'package:domain/services/login_service.dart';
import 'package:domain/services/secure_storage_service.dart';
import 'package:domain/services/token_service.dart';
import 'package:get_it/get_it.dart';

class TryLoginUseCase {
  final LoginService _loginService = GetIt.I.get<LoginService>();
  final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  final TokenService _tokenService = GetIt.I.get<TokenService>();
  final SecureStorageService _secureStorageService =
      GetIt.I.get<SecureStorageService>();

  Future<bool> call(String userName, String phoneNumber) async {
    await _firebaseService.init();
    final token = await _firebaseService.getToken();
    final result =
        await _loginService.saveUserInfo(userName, phoneNumber, token);

    if (result.isMember) {
      final accessToken = result.accessToken!;
      final refreshToken = result.refreshToken!;
      _tokenService.setToken(accessToken, refreshToken);
      await Future.wait([
        _secureStorageService.saveAccessToken(accessToken),
        _secureStorageService.saveRefreshToken(refreshToken),
      ]);
    }

    return result.isMember;
  }
}
