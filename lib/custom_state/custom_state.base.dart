/*
 Created by Thanh Son on 2/8/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:custom_state/custom_state/custom_state_mixin.dart';
import 'package:custom_state/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom view with S state
///
class CustomStateView<S> extends StatefulWidget {
  const CustomStateView({
    Key? key,
    required this.stateBuilder,
    this.states,
    this.initialStates = const {},
  }) : super(key: key);

  /// return Widget with S state
  final StateBuilder<CustomStateView, S> stateBuilder;

  /// [states] != null with be apply this state, else with be apply with setCustomState function in key
  final Set<S>? states;

  /// [initialStates] != null with be apply in initState, default is {}
  final Set<S> initialStates;

  @override
  State<StatefulWidget> createState() => _CustomState<S>();
}

class _CustomState<S> extends State<CustomStateView<S>>
    with CustomState<CustomStateView<S>, S> {
  Widget? child;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customState = widget.states ?? widget.initialStates;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.states != null) {
      customState = widget.states!;
    }
    child = widget.stateBuilder(context, customState, this);
    return child!;
  }
}
