import 'package:data/remote/http/pcube_api.dart';
import 'package:data/remote/p_cube_plus_api/project/response/project_dto.dart';
import 'package:data/remote/p_cube_plus_api/user/models/user_profile_dto.dart';
import 'package:data/remote/p_cube_plus_api/user/models/user_total_warning_dto.dart';
import 'package:data/utils/json_util.dart';

class UserRemoteDatasource {
  /// part: [???]
  /// level: [탈퇴자, 정회원, 수습회원, 명예회원, 수습회원(휴학), 졸업생]
  /// restType: [활동, 일반휴학, 군휴학]
  Future<List<UserProfileDTO>> getUserProfileList(
    String part,
    String level,
    String restType,
  ) async {
    var response = await PCubeApi(
      "/user/project?part=$part&level=$level&rest_type=$restType",
    ).get();
    return JsonUtil()
        .convertToList<UserProfileDTO>(UserProfileDTO.fromJson, response.body);
  }

  Future<UserProfileDTO> getUserProfile() async {
    var response = await PCubeApi("/user/profile").get();
    return JsonUtil()
        .convertTo<UserProfileDTO>(UserProfileDTO.fromJson, response.body);
  }

  Future<List<ProjectResponseDTO>> getUserProject() async {
    var response = await PCubeApi("/user/project").get();
    return JsonUtil().convertToList<ProjectResponseDTO>(
        ProjectResponseDTO.fromJson, response.body);
  }

  Future<UserTotalWarningDTO> getUserWarning() async {
    var response = await PCubeApi("/user/warning").get();
    return JsonUtil().convertTo<UserTotalWarningDTO>(
        UserTotalWarningDTO.fromJson, response.body);
  }
}
