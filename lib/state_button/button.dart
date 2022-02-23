/*
 Created by Thanh Son on 2/2/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:custom_state/custom_state.dart';

enum ButtonState { initial, progressing, success, fail, disable, done }

/// ButtonStateProperty with be return T state with ButtonState
mixin ButtonStateProperty<T> implements StateProperty<ButtonState, T> {
  /// update state field
  ButtonStateProperty<T> withState(Set<ButtonState> states);
}
