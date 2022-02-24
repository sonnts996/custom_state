/*
 Created by Thanh Son on 2/8/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Base custom state with S state for the T StatefulWidget
mixin CustomState<T extends StatefulWidget, S> on State<T> {
  /// customState field of CustomStateMixin widget
  Set<S> customState = {};

  /// replace [customState] by [states] and rebuild
  void replaceCustomState(Set<S> states) {
    customState.clear();
    customState.addAll(states);
    setState(() {});
  }

  /// add [_state] to [customState] and rebuild
  void addCustomState(S _state) {
    if (customState.add(_state)) {
      setState(() {});
    }
  }

  /// remove [_state] from [customState] and rebuild
  void removeCustomState(S _state) {
    if (customState.remove(_state)) {
      setState(() {});
    }
  }

  /// add or set move [_state] from [customState] and rebuild
  void setCustomState(S _state, bool isSet) {
    return isSet ? addCustomState(_state) : removeCustomState(_state);
  }

  /// update [_state] function
  ValueChanged<bool> updateCustomState(S _state,
      {ValueChanged<bool>? onChanged}) {
    return (bool value) {
      if (customState.contains(_state)) {
        return;
      }
      setCustomState(_state, value);
      onChanged?.call(value);
    };
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Set<S>>(
      'customStates',
      customState,
      defaultValue: <S>{},
    ));
  }
}
