import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';

abstract class RefreshableProvider<dataType> {
  Future<dataType> fetch();
  Future<dataType> refresh();
  dataType get data;
}

class ApiProviderBase<dataType>
    with ChangeNotifier
    implements RefreshableProvider {
  ApiProviderBase({required this.client});

  PCubeApi client;

  dataType? _cachedData;

  @override
  dataType get data => _cachedData!;

  @override
  Future<dataType> fetch() async => _cachedData ?? await refresh();

  @override
  Future<dataType> refresh({Map<String, String>? queryParams}) async {
    _cachedData = await client.get(queryParams: queryParams);
    return _cachedData!;
  }
}

abstract class DummyProviderBase<dataType>
    with ChangeNotifier
    implements RefreshableProvider {
  dataType getDummy({Object? parameter});
  dataType? _cachedData;

  @override
  dataType get data => _cachedData!;

  @override
  Future<dataType> fetch() async => _cachedData ?? await refresh();

  @override
  Future<dataType> refresh({Object? parameter}) async {
    _cachedData = getDummy(parameter: parameter);
    return _cachedData!;
  }
}

class CompositeProviderBase implements RefreshableProvider {
  CompositeProviderBase({required this.providerList});

  List<RefreshableProvider> providerList;

  @override
  List<RefreshableProvider> get data => providerList;

  @override
  Future<List<RefreshableProvider>> fetch() async {
    for (int i = 0; i < providerList.length; ++i) {
      await providerList[i].fetch();
    }
    return providerList;
  }

  @override
  Future<List<RefreshableProvider>> refresh() async {
    for (int i = 0; i < providerList.length; ++i) {
      await providerList[i].refresh();
    }
    return providerList;
  }
}
