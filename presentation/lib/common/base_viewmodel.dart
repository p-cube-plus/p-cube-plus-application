import 'dart:async';
import 'package:flutter/material.dart';

class BaseViewModel<S, E> extends ChangeNotifier {
  final _uiStateStream = StreamController<S>.broadcast();
  Stream<S> get uiStateStream => _uiStateStream.stream;

  final _eventStream = StreamController<E>.broadcast();
  Stream<E> get eventStream => _eventStream.stream;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  void changeState(S state) {
    if (_uiStateStream.isClosed) return;
    _uiStateStream.add(state);
  }

  void triggerEvent(E event) {
    if (_eventStream.isClosed) return;
    _eventStream.add(event);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _uiStateStream.close();
    _eventStream.close();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
