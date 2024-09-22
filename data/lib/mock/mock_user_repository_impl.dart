import 'package:domain/user/repository/user_repository.dart';
import 'package:domain/user/value_objects/user_profile.dart';
import 'package:domain/user/value_objects/user_project.dart';
import 'package:domain/user/value_objects/user_project_detail.dart';
import 'package:domain/user/value_objects/user_warning.dart';
import 'package:domain/user/value_objects/user_warning_detail.dart';

class MockUserRepositoryImpl implements UserRepository {
  @override
  Future<UserWarning> getUserCumulativeWarning() {
    // TODO: implement getUserCumulativeWarning
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<List<UserProject>> getUserProject() {
    // TODO: implement getUserProject
    throw UnimplementedError();
  }

  @override
  Future<List<UserProjectDetail>> getUserProjectDetail() {
    // TODO: implement getUserProjectDetail
    throw UnimplementedError();
  }

  @override
  Future<List<UserWarningDetail>> getUserWarningDetail() {
    // TODO: implement getUserWarningDetail
    throw UnimplementedError();
  }
}
