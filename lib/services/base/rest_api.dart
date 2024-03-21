class RestApi {
  String _url = "";
  Map<String, String> _headers = {};
  Map<String, Object> _body = {};

  _getUrlWithQueryParams(String currentUrl, Map<String, String> queryParams) {
  currentUrl += "?";
  for (String key in queryParams.keys) {
    var value = queryParams[key];
    currentUrl += "$key=$value&";
  }
  return currentUrl.substring(0, currentUrl.length - 1);
  }

  getUrl(String baseUrl, String endPoint, {Map<String, String>? queryParams = null}) {
  _url = baseUrl + endPoint;
  if ((queryParams?.length ?? 0) == 0) return;
  _url = _getUrlWithQueryParams(_url, queryParams!);
  }

    CreateDefaultRequest(String url)
    {
        var request = WebRequest.Create(url) as HttpWebRequest;
        request.Method = method.ToString();
        request.KeepAlive = true;
        request.Credentials = CredentialCache.DefaultCredentials;

        if (headers != null)
            foreach (var header in headers)
                request.Headers.Add(header.Key, header.Value);

        return request;
    }

      PostJson(string url, Headers headers = null, Body body = null)
    {
        return SendJson(HttpMethod.POST, url, headers, body);
    }
}