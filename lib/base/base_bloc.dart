import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hienhien/base/base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController = StreamController();
  Sink<BaseEvent> get event => _eventStreamController.sink;
  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) throw Exception('Event is not suitable');

      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);
  
  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
