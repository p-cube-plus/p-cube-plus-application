// JObject
// JArray

// IResponse.fromJson()
abstract class IResponse {
  T convertTo<T extends IResponse>(String responseBody);
}

class RestApi {
  _getUrlWithQueryParams(String currentUrl, Map<String, String> queryParams) {
  currentUrl += "?";
  for (String key in queryParams.keys) {
    var value = queryParams[key];
    currentUrl += "$key=$value&";
  }
  return currentUrl.substring(0, currentUrl.length - 1);
  }

  getUrl(String baseUrl, String endPoint, {Map<String, String>? queryParams = null}) {
    var _url = baseUrl + endPoint;
    if ((queryParams?.length ?? 0) == 0) return _url;
    return _getUrlWithQueryParams(_url, queryParams!);
  }

  getHeader({String? token = null, String contentType = "application/json", int timeout = 5000}) {
  }
}