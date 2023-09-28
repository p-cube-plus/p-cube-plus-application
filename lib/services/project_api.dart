import '../models/project.dart';
import 'base/pcube_api.dart';

class ProjectListApi extends PCubeApi {
  ProjectListApi({int? id}) : super(endPoint: "/project");

  @override
  Future<List<Project>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers}) async {
    return await super.get(
        decodeFunction: (jsonDecodeData) =>
            jsonDecodeData.map((e) => Project.fromJson(e)).toList());
  }
}
