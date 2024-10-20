import 'dart:async';
import 'package:flutter/material.dart';

class BaseViewModel<ViewModelEvent, UiEvent> extends ChangeNotifier {
  final _eventStream = StreamController<ViewModelEvent>.broadcast();
  Stream<ViewModelEvent> get eventStream => _eventStream.stream;

  final _uiEventStream = StreamController<UiEvent>.broadcast();
  Stream<UiEvent> get uiEventStream => _uiEventStream.stream;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  void triggerEvent(ViewModelEvent event) {
    if (_eventStream.isClosed) return;
    _eventStream.add(event);
  }

  void triggerUiEvent(UiEvent event) {
    if (_uiEventStream.isClosed) return;
    _uiEventStream.add(event);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _eventStream.close();
    _uiEventStream.close();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
