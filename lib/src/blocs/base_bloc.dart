import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../utilities/utilities.dart';

abstract class BaseBloc<T extends dynamic> {
  BaseBloc({T? state}) {
    if (state == null) {
      _controller = BehaviorSubject<T>();
    } else {
      _controller = BehaviorSubject<T>.seeded(state);
    }
  }

  late BehaviorSubject<T> _controller;
  final _listenerController = BehaviorSubject<dynamic>();
  final _loadingController = BehaviorSubject<bool>.seeded(false);
  final _waitingController = BehaviorSubject<bool>.seeded(false);
  final _restStatusCodeController = BehaviorSubject<int>();

  Stream<bool> get loadingStream => _loadingController.stream;

  Stream<bool> get waitingStream => _waitingController.stream;

  Stream<T> get stateStream => _controller.stream;

  Stream<int> get restStatusCodeStream => _restStatusCodeController.stream;

  Stream<dynamic> get listenerStream => _listenerController.stream;

  Sink<bool> get loading => _loadingController.sink;

  Sink<bool> get waiting => _waitingController.sink;

  Sink<dynamic> get listener => _listenerController.sink;

  T? get state {
    try {
      final value = _controller.value;
      return value;
    } catch (e) {
      Log.e('${e.toString()}', tag: '$runtimeType');
    }
    return null;
  }

  bool get waitingValue => _waitingController.value;

  bool get loadingValue => _loadingController.value;

  @mustCallSuper
  void dispose() {
    loading.close();
    waiting.close();
    listener.close();

    _controller.close();
    _listenerController.close();
    _loadingController.close();
    _waitingController.close();
    _restStatusCodeController.close();
  }

  @mustCallSuper
  void onResume() {}

  @mustCallSuper
  void onPause() {}

  @mustCallSuper
  void onDetach() {}

  @mustCallSuper
  void onInactive() {}

  void emit(dynamic state) => _controller.sink.add(state);

  void addError(Object error, [StackTrace? stackTrace]) {
    if (_controller.isClosed) return;
    _controller.sink.addError(error, stackTrace);
  }

  void emitStatusCode(int statusCode) => _restStatusCodeController.sink.add(statusCode);
}
