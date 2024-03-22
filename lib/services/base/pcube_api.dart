import 'package:http/http.dart';
import 'package:p_cube_plus_application/services/base/rest_api.dart';
import 'package:p_cube_plus_application/utilities/api_util.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

const String _baseUrl = "http://p-cube-plus.com";

class PCubeApi {
  const PCubeApi(this.endPoint);
  final String endPoint;

  Future<Map<String, String>> _getTokenHeader() async {
    String? token = await TokenManager().getAccessToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<Response> post(
      {Object? body,
      Map<String, String>? queryParams,
      Map<String, String>? additionalHeader}) async {
    var header = await _getTokenHeader();
    header.addAll(additionalHeader ?? {});
    return RestApi.instance.post(
        ApiUtil.instance.getUrl(_baseUrl, endPoint, queryParams: queryParams),
        header,
        body: body);
  }

  Future<Response> get(
      {Map<String, String>? queryParams,
      Map<String, String>? additionalHeader}) async {
    var header = await _getTokenHeader();
    header.addAll(additionalHeader ?? {});
    return RestApi.instance.get(
        ApiUtil.instance.getUrl(_baseUrl, endPoint, queryParams: queryParams),
        header);
  }

  Future<Response> put(
      {Object? body,
      Map<String, String>? queryParams,
      Map<String, String>? additionalHeader}) async {
    var header = await _getTokenHeader();
    header.addAll(additionalHeader ?? {});
    return RestApi.instance.put(
        ApiUtil.instance.getUrl(_baseUrl, endPoint, queryParams: queryParams),
        header,
        body: body);
  }

  Future<Response> delete(
      {Object? body,
      Map<String, String>? queryParams,
      Map<String, String>? additionalHeader}) async {
    var header = await _getTokenHeader();
    header.addAll(additionalHeader ?? {});
    return RestApi.instance.delete(
        ApiUtil.instance.getUrl(_baseUrl, endPoint, queryParams: queryParams),
        header,
        body: body);
  }

  Map<String, String> _getJsonContentHeader() =>
      {"Content-Type": "application/json"};

  Future<Response> getExceptToken(
      {Map<String, String>? additionalHeader}) async {
    var header = _getJsonContentHeader();
    header.addAll(additionalHeader ?? {});
    return RestApi.instance
        .get(ApiUtil.instance.getUrl(_baseUrl, endPoint), header);
  }

  Future<Response> deleteExceptToken(
      {Map<String, String>? additionalHeader}) async {
    var header = _getJsonContentHeader();
    header.addAll(additionalHeader ?? {});
    return RestApi.instance
        .delete(ApiUtil.instance.getUrl(_baseUrl, endPoint), header);
  }
}
