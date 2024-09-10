import 'package:data/remote/http/pcube_api.dart';
import 'package:data/remote/p_cube_plus_api/seminar/body/add_seminar_body_dto.dart';
import 'package:data/remote/p_cube_plus_api/seminar/body/update_seminar_body_dto.dart';
import 'package:data/remote/p_cube_plus_api/seminar/response/seminar_response_dto.dart';
import 'package:data/utils/json_util.dart';

class SeminarRemoteDatasource {
  Future<List<SeminarResponseDTO>> getSeminar(String userId) async {
    final response = await PCubeApi("/seminar").get();
    return JsonUtil().convertToList<SeminarResponseDTO>(
        SeminarResponseDTO.fromJson, response.body);
  }

  Future<void> updateSeminar(UpdateSeminarBodyDTO body) async {
    await PCubeApi("/seminar").put(body: JsonUtil().mapToJson(body.toMap()));
  }

  Future<void> deleteSeminar(String seminarId) async {
    await PCubeApi("/seminar?id=$seminarId").delete();
  }

  Future<void> addSeminar(String userId, AddSeminarBodyDTO body) async {
    await PCubeApi("/seminar?user_id=$userId")
        .post(body: JsonUtil().mapToJson(body.toMap()));
  }
}
