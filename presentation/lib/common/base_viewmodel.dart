import 'dart:async';
import 'package:flutter/material.dart';

class BaseViewModel<Event> extends ChangeNotifier {
  StreamController<Event>? _eventStream;
  bool _isDisposed = false;

  Stream<Event> get eventStream {
    _eventStream ??= StreamController<Event>.broadcast();
    return _eventStream!.stream;
  }

  void triggerEvent(Event event) {
    if (_eventStream == null) return;
    if (_eventStream!.isClosed) return;
    _eventStream!.add(event);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _eventStream?.close();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
