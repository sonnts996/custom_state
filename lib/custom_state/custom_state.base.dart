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
  }) : super(key: key);

  /// return Widget with S state
  final StateBuilder<CustomStateView, S> stateBuilder;

  @override
  State<StatefulWidget> createState() => CustomState<S>();
}

class CustomState<S> extends State<CustomStateView<S>>
    with CustomStateMixin<CustomStateView<S>, S> {
  Widget? child;

  @override
  Widget build(BuildContext context) {
    child = widget.stateBuilder(context, customState, this);
    return child!;
  }
}
