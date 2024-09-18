import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/remote/p_cube_api/project/response/project_dto.dart';
import 'package:data/remote/p_cube_api/user/models/user_profile_dto.dart';
import 'package:data/remote/p_cube_api/user/models/user_total_warning_dto.dart';
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
    var response = await PCubeApi().get(
      "/user/project",
      queryParameters: {
        "part": part,
        "level": level,
        "rest_type": restType,
      },
    );
    return JsonUtil()
        .convertToList<UserProfileDTO>(UserProfileDTO.fromJson, response.body);
  }

  Future<UserProfileDTO> getUserProfile() async {
    var response = await PCubeApi().get("/user/profile");
    return JsonUtil()
        .convertTo<UserProfileDTO>(UserProfileDTO.fromJson, response.body);
  }

  Future<List<ProjectResponseDTO>> getUserProject() async {
    var response = await PCubeApi().get("/user/project");
    return JsonUtil().convertToList<ProjectResponseDTO>(
        ProjectResponseDTO.fromJson, response.body);
  }

  Future<UserTotalWarningDTO> getUserWarning() async {
    var response = await PCubeApi().get("/user/warning");
    return JsonUtil().convertTo<UserTotalWarningDTO>(
        UserTotalWarningDTO.fromJson, response.body);
  }
}
