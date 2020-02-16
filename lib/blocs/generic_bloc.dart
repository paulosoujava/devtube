import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class GenericBloc<T>{
  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  add(T event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  addError(String error) {
    if (!_controller.isClosed) {
      _controller.addError(error);
    }
  }

  void dispose() {
    _controller.close();
  }
}