/*
 Created by Thanh Son on 2/2/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:custom_state/custom_state.dart';
import 'package:flutter/material.dart';

enum ButtonState {
  // state when start
  initial,
  // state when loading
  progressing,
  // state success
  success,
  // state fail
  fail,
  // state disable, it will be decrease alpha color of current state
  disabled,
  // like initial, but after action
  done,
  // state disable, it will be use disable widget and style
  forceDisabled
}

/// ButtonStateProperty with be return T state with ButtonState
mixin ButtonStateProperty<T> implements StateProperty<ButtonState, T> {
  /// update state field
  ButtonStateProperty<T> withState(Set<ButtonState> states);
}

/// check for set alpha color
bool disableAlpha(Set<MaterialState> material, Set<ButtonState> button) {
  return (material.contains(MaterialState.disabled) ||
          button.contains(ButtonState.disabled)) &&
      !button.contains(ButtonState.forceDisabled);
}

/// disable flag
bool disable(Set<ButtonState> button) {
  return button.contains(ButtonState.disabled) ||
      button.contains(ButtonState.forceDisabled);
}
