import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class TryLoginUseCase {
  final LoginRepository _loginService = GetIt.I.get<LoginRepository>();
  // final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  // final TokenService _tokenService = GetIt.I.get<TokenService>();
  // final SecureStorageService _secureStorageService =
  //     GetIt.I.get<SecureStorageService>();

  Future<bool> call(String userName, String phoneNumber) async {
    // await _firebaseService.init();
    // final token = await _firebaseService.getToken();
    // final result =
    //     await _loginService.saveUserInfo(userName, phoneNumber, token);

    // if (result.isMember) {
    //   final accessToken = result.accessToken!;
    //   final refreshToken = result.refreshToken!;
    //   _tokenService.setToken(accessToken, refreshToken);
    //   await Future.wait([
    //     _secureStorageService.saveAccessToken(accessToken),
    //     _secureStorageService.saveRefreshToken(refreshToken),
    //   ]);
    // }

    //return result.isMember;
    return true;
  }
}
