/*
 Created by Thanh Son on 2/2/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:custom_state/custom_state/custom_state_mixin.dart';
import 'package:flutter/material.dart';

/// return T value with the S state
typedef PropertyResolver<S, T> = T Function(Set<S> states);

/// return Widget with S state
typedef StateBuilder<T extends StatefulWidget, S> = Widget Function(
    BuildContext context, Set<S> states, CustomState<T, S> customState);

/// return S state when call
typedef StateFutureFunction<S> = Future<S> Function({S? currentState});

/// function with CustomStateMixin for call setCustomState
typedef StateFunction<T extends StatefulWidget, S> = void Function(
    CustomState<T, S> customState);
