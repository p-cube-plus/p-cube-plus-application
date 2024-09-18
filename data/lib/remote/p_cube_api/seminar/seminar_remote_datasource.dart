import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/remote/p_cube_api/seminar/body/add_seminar_body_dto.dart';
import 'package:data/remote/p_cube_api/seminar/body/update_seminar_body_dto.dart';
import 'package:data/remote/p_cube_api/seminar/response/seminar_response_dto.dart';
import 'package:data/utils/json_util.dart';

class SeminarRemoteDatasource {
  Future<List<SeminarResponseDTO>> getSeminar(String userId) async {
    final response = await PCubeApi().get("/seminar");
    return JsonUtil().convertToList<SeminarResponseDTO>(
        SeminarResponseDTO.fromJson, response.body);
  }

  Future<void> updateSeminar(UpdateSeminarBodyDTO body) async {
    await PCubeApi().put(
      "/seminar",
      body: JsonUtil().mapToJson(body.toMap()),
    );
  }

  Future<void> deleteSeminar(String seminarId) async {
    await PCubeApi().delete(
      "/seminar",
      queryParameters: {
        "id": seminarId,
      },
    );
  }

  Future<void> addSeminar(String userId, AddSeminarBodyDTO body) async {
    await PCubeApi().post(
      "/seminar",
      queryParameters: {
        "user_id": userId,
      },
      body: JsonUtil().mapToJson(body.toMap()),
    );
  }
}
