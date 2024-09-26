import 'dart:async';
import 'package:flutter/material.dart';

class BaseViewModel<S, E> extends ChangeNotifier {
  final _viewState = StreamController<S>.broadcast();
  Stream<S> get uiEventStream => _viewState.stream;

  final _viewEvent = StreamController<E>.broadcast();
  Stream<E> get userActionEventStream => _viewEvent.stream;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  void changeViewState(S state) {
    if (_viewState.isClosed) return;
    _viewState.add(state);
  }

  void triggerEvent(E event) {
    if (_viewEvent.isClosed) return;
    _viewEvent.add(event);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _viewState.close();
    _viewEvent.close();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
