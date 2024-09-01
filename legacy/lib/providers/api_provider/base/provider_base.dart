import 'dart:async';
import 'package:flutter/material.dart';

abstract class RefreshableProvider<dataType> {
  Future<dataType> fetch() async => _cachedData ?? await refresh();
  Future<dataType> refresh();
  dataType get data => _cachedData!;
  dataType? _cachedData;
}

class ApiProviderBase<dataType>
    with ChangeNotifier, RefreshableProvider<dataType> {
  ApiProviderBase({required this.getFunction});
  final Function getFunction;

  @override
  Future<dataType> refresh({Map<String, String>? queryParams}) async {
    _cachedData = await getFunction();
    return _cachedData!;
  }
}

class CompositeProviderBase {
  CompositeProviderBase({required this.providerMap});
  final Map<Symbol, RefreshableProvider> providerMap;

  Future<Map<Symbol, RefreshableProvider>> fetch() async {
    for (var key in providerMap.keys) {
      await providerMap[key]!.fetch();
    }
    return providerMap;
  }

  Future<Map<Symbol, RefreshableProvider>> refresh() async {
    for (var key in providerMap.keys) {
      await providerMap[key]!.refresh();
    }
    return providerMap;
  }
}
