import 'package:flutter/material.dart';

enum HookDataState { idle, loading, updating, loaded, error }

class HookDataContainer<M> {
  ValueNotifier<HookDataState> state = ValueNotifier(HookDataState.idle);
  M? _data;
  M? get data => _data;
  Object? _error;
  Object? get error => _error;
  void setData(M? data) {
    _data = data;
    state.value = HookDataState.loaded;
  }

  void setError(Object error) {
    _error = error;
    state.value = HookDataState.error;
  }
}
