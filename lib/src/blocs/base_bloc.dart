import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends dynamic> {
  BaseBloc({T state}) {
    _controller = BehaviorSubject<T>.seeded(state);
  }

  BehaviorSubject<T> _controller;
  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();
  final BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _waitingController = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<int> _restStatusCodeController = BehaviorSubject<int>();

  Stream<bool> get loadingStream => _loadingController?.stream;

  Stream<bool> get waitingStream => _waitingController?.stream;

  Stream<T> get stateStream => _controller?.stream;

  Stream<int> get restStatusCodeStream => _restStatusCodeController?.stream;

  Stream<dynamic> get listenerStream => _listenerController?.stream;

  Sink<bool> get loading => _loadingController?.sink;

  Sink<bool> get waiting => _waitingController?.sink;

  Sink<dynamic> get listener => _listenerController?.sink;

  T get state => _controller?.value;

  bool get waitingValue => _waitingController?.value;

  bool get loadingValue => _loadingController?.value;

  @mustCallSuper
  void dispose() {
    loading?.close();
    waiting?.close();
    listener?.close();

    _controller?.close();
    _listenerController?.close();
    _loadingController?.close();
    _waitingController?.close();
    _restStatusCodeController?.close();
  }

  @mustCallSuper
  void onResume() {}

  @mustCallSuper
  void onPause() {}

  @mustCallSuper
  void onDetach() {}

  @mustCallSuper
  void onInactive() {}

  void emit(dynamic state) => _controller?.sink?.add(state);

  void addError(Object error, [StackTrace stackTrace]) {
    if (_controller?.isClosed ?? true) return;
    _controller?.sink?.addError(error, stackTrace);
  }

  void emitStatusCode(int statusCode) => _restStatusCodeController?.sink?.add(statusCode);
}
