import 'dart:async';
import 'package:rxdart/rxdart.dart';

abstract class CustomBloc<E, S> {
  final _eventController = BehaviorSubject<E>();
  final _stateController = BehaviorSubject<S>();
  StreamSubscription<E>? _subscription;
  Stream<S> get states => _stateController.stream;
  S state;
  CustomBloc(this.state) {
    _subscription = _eventController.stream.listen(handleEvent);
  }

  stopListening() {
    _subscription?.cancel();
  }

  //to override
  void handleEvent(E event);

  void add(E event) {
    _eventController.sink.add(event);
  }

  void emit(S state) {
    this.state = state;
    _stateController.sink.add(state);
  }

  void dispose() {
    stopListening();
  }
}
