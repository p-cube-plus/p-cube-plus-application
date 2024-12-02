enum RouteType {
  login("/login"),
  alarm("/alarm"),
  home("/home"),
  user("/user"),
  ;

  final String _routePath;
  const RouteType(this._routePath);

  String get routeName {
    return _routePath.split("/").last;
  }

  List<String> get routePath {
    List<String> result = [];
    final routeNameList = _routePath.split("/");
    routeNameList.removeAt(0);

    for (final routeName in routeNameList) {
      result.add("/$routeName");
    }
    return result;
  }
}
