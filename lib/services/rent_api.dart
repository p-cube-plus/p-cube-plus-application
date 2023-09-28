import '../models/rent.dart';
import 'base/pcube_api.dart';

class RentListApi extends PCubeApi {
  RentListApi({int? id}) : super(endPoint: "/rent/${id?.toString() ?? "list"}");

  @override
  Future<List<Rent>?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers}) async {
    return await super.get(
        decodeFunction: (jsonDecodeData) => (jsonDecodeData as List)
            .map((data) => Rent.fromJson(data))
            .toList());
  }
}
