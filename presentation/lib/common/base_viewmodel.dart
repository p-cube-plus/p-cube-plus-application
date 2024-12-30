import 'dart:async';
import 'package:flutter/material.dart';

class BaseViewModel<UiEvent> extends ChangeNotifier {
  StreamController<UiEvent>? _uiEventStream;
  bool _isDisposed = false;

  Stream<UiEvent> get uiEventStream {
    _uiEventStream ??= StreamController<UiEvent>.broadcast();
    return _uiEventStream!.stream;
  }

  void triggerEvent(UiEvent event) {
    if (_uiEventStream == null) return;
    if (_uiEventStream!.isClosed) return;
    _uiEventStream!.add(event);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _uiEventStream?.close();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
