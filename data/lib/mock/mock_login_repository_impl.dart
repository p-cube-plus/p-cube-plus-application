import 'dart:math';

import 'package:data/local/secure_storage/secure_storage_local_datasource.dart';
import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/firebase/firebase_manager.dart';
import 'package:data/remote/p_cube_api/auth/auth_remote_datasource.dart';
import 'package:data/remote/p_cube_api/oauth/oauth_remote_datasource.dart';
import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:domain/login/repository/login_repository.dart';
import 'package:domain/login/value_objects/auth_token_data.dart';
import 'package:domain/login/value_objects/login_confirm_info_data.dart';
import 'package:domain/login/value_objects/login_request_info_data.dart';
import 'package:domain/login/value_objects/login_user_info_data.dart';
import 'package:get_it/get_it.dart';

class MockLoginRepositoryImpl implements LoginRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();
  final secureStorageLocalDatasource =
      GetIt.I.get<SecureStorageLocalDatasource>();
  final oAuthRemoteDatasource = GetIt.I.get<OauthRemoteDatasource>();
  final authRemoteDatasource = GetIt.I.get<AuthRemoteDatasource>();
  final firebaseDatasource = GetIt.I.get<FirebaseManager>();

  @override
  Future<LoginUserInfoData> authenticateUser(
      String name, String phoneNumber, String messageToken) async {
    await Future.delayed(Duration(seconds: 5));
    return LoginUserInfoData(
      isMember: true,
      tokenData: AuthTokenData(accessToken: "mock", refreshToken: "mock"),
    );
  }

  @override
  Future<LoginConfirmInfoData> confirmAuthNumber(String code) async {
    await Future.delayed(Duration(seconds: Random.secure().nextInt(5)));
    return LoginConfirmInfoData(isVerified: true);
  }

  @override
  Future<String?> getRefreshToken() {
    return secureStorageLocalDatasource.getRefreshToken();
  }

  @override
  Future<String?> getToken() {
    return secureStorageLocalDatasource.getAccessToken();
  }

  @override
  Future<void> logout() {
    return Future.wait([
      authRemoteDatasource.deleteToken(),
      secureStorageLocalDatasource.deleteAccessToken(),
      secureStorageLocalDatasource.deleteRefreshToken(),
    ]);
  }

  @override
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber) async {
    await Future.delayed(Duration(seconds: Random.secure().nextInt(5)));
    return LoginRequestInfoData(isValid: true);
  }

  @override
  Future<void> setToken(String accessToken, String refreshToken) async {
    PCubeApi().setToken(accessToken, refreshToken);
    await Future.wait([
      secureStorageLocalDatasource.saveAccessToken(accessToken),
      secureStorageLocalDatasource.saveRefreshToken(refreshToken),
    ]);
  }

  @override
  Future<String?> getFcmToken() {
    return firebaseDatasource.getFcmToken();
  }
}
