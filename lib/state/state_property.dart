/*
 Created by Thanh Son on 2/4/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:custom_state/functions/functions.dart';

/// StateProperty with be return T state with S state
abstract class StateProperty<S, T> {
  T resolveProp(Set<S> states);

  static T resolvePropAs<S, T>(T value, Set<S> states) {
    if (value is StateProperty<S, T>) {
      final StateProperty<S, T> property = value;
      return property.resolveProp(states);
    }
    return value;
  }

  static StateProperty<S, T> resolvePropWith<S, T>(
          PropertyResolver<S, T> callback) =>
      _StatePropertyWith<S, T>(callback);

  static StateProperty<S, T> allProp<S, T>(T value) =>
      _StatePropertyAll<S, T>(value);
}

class _StatePropertyWith<S, T> implements StateProperty<S, T> {
  _StatePropertyWith(this._resolve);

  final PropertyResolver<S, T> _resolve;

  @override
  T resolveProp(Set<S> states) => _resolve(states);
}

class _StatePropertyAll<S, T> implements StateProperty<S, T> {
  _StatePropertyAll(this.value);

  final T value;

  @override
  T resolveProp(Set<S> states) => value;

  @override
  String toString() => 'StateProperty.all($value)';
}
