import 'dart:async';
import 'package:flutter/material.dart';

class BaseViewModel<S, E> extends ChangeNotifier {
  final _uiSideEffect = StreamController<S>.broadcast();
  Stream<S> get uiSideEffectStream => _uiSideEffect.stream;

  final _userActionEvent = StreamController<E>.broadcast();
  Stream<E> get userActionEventStream => _userActionEvent.stream;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  void changeState(S state) {
    if (_uiSideEffect.isClosed) return;
    _uiSideEffect.add(state);
  }

  void triggerEvent(E event) {
    if (_userActionEvent.isClosed) return;
    _userActionEvent.add(event);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _uiSideEffect.close();
    _userActionEvent.close();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
