/*
 Created by Thanh Son on 2/8/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:custom_state/custom_state/custom_state_mixin.dart';
import 'package:custom_state/functions/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'button.dart';

///
/// - Build ElevatedButton with decoration change follow state
/// - [onTap] the function run when press the button
/// - [initial] is default child widget, in undefine state
/// - [fail], [success], [loader] will show
/// in [ButtonState.fail], [ButtonState.success] and [ButtonState.progressing]
/// - [style] use StateButton.styleFrom for custom style, null with be use theme style or default
/// - [icon] is default if use ElevatedButton.icon
/// - [failIcon], [successIcon], [loaderIcon] will be replace the icon field in
/// the corresponding state [ButtonState.fail], [ButtonState.success] and [ButtonState.progressing]
/// - [states] != null with be apply this state, else with be apply with setCustomState function in key
/// - for define key:
///       final GlobalKey<CustomStateMixin<StateButton, ButtonState>> stateButtonKey = GlobalKey();
class StateButton extends StatefulWidget {
  const StateButton(
      {Key? key,
      required this.onTap,
      required this.initial,
      this.fail,
      this.success,
      this.loader,
      this.style,
      this.icon,
      this.disable,
      this.loaderIcon,
      this.failIcon,
      this.successIcon,
      this.disableIcon,
      this.states})
      : super(key: key);

  /// StateButton with [states] = null
  /// and without use global key.
  /// The state will be [ButtonState.progressing] when [futureOnTab] start
  /// and end with ButtonState return in [futureOnTab]
  ///
  factory StateButton.future(
      {Key? key,
      required StateFutureFunction<Set<ButtonState>> futureOnTab,
      required Widget initial,
      Widget? icon,
      Widget? loaderIcon,
      Widget? successIcon,
      Widget? failIcon,
      Widget? disableIcon,
      Widget? fail,
      Widget? success,
      Widget? loader,
      Widget? disable,
      ButtonStyle? style,
      bool hasState = true}) {
    Future _future(CustomState<dynamic, ButtonState> customState) async {
      customState.updateCustomState(ButtonState.progressing).call(true);
      final states = await futureOnTab(currentState: customState.customState);
      customState.replaceCustomState(states);
    }

    return StateButton(
      key: key,
      onTap: (CustomState<StateButton, ButtonState> customState) {
        _future(customState);
      },
      initial: initial,
      icon: icon,
      loaderIcon: loaderIcon,
      failIcon: failIcon,
      successIcon: successIcon,
      style: style,
      fail: fail,
      success: success,
      loader: loader,
      disable: disable,
      disableIcon: disableIcon,
    );
  }

  /// the function run when press the button
  final StateFunction<StateButton, ButtonState> onTap;

  /// default if use ElevatedButton.icon
  final Widget? icon;

  /// [ButtonState.progressing] if use ElevatedButton.icon
  final Widget? loaderIcon;

  /// [ButtonState.success] if use ElevatedButton.icon
  final Widget? successIcon;

  /// [ButtonState.fail] if use ElevatedButton.icon
  final Widget? failIcon;

  /// [ButtonState.forceDisabled] if use ElevatedButton.icon
  final Widget? disableIcon;

  ///  default child widget, in undefine state
  final Widget initial;

  /// [ButtonState.fail] child widget
  final Widget? fail;

  /// [ButtonState.success] child widget
  final Widget? success;

  /// [ButtonState.loader] child widget
  final Widget? loader;

  /// [ButtonState.forceDisabled] child widget
  final Widget? disable;

  /// custom style child widget
  final ButtonStyle? style;

  /// [states] != null with be apply this state, else with be apply with setCustomState function in key
  final Set<ButtonState>? states;

  /// like ElevatedButton.styleFrom with state color for background [success], [fail]
  /// and state color for foreground [onSuccess], [onFail]
  static ButtonStyle styleFrom({
    Color? primary,
    Color? onPrimary,
    Color? onSurface,
    Color? shadowColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    //extend fields
    Color? success,
    Color? onSuccess,
    Color? fail,
    Color? onFail,
    Color? disable,
    Color? onDisable,
  }) {
    final style = ElevatedButton.styleFrom(
      primary: primary,
      onPrimary: onPrimary,
      onSurface: onSurface,
      shadowColor: shadowColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );

    final _StateBackground? backgroundColor = (onSurface == null &&
            primary == null &&
            fail == null &&
            success == null)
        ? null
        : _StateBackground(
            primary: primary,
            onSurface: onSurface,
            fail: fail,
            success: success,
            disable: disable,
          );
    final _StateForeground? foregroundColor = (onSurface == null &&
            onPrimary == null &&
            onFail == null &&
            onSuccess == null)
        ? null
        : _StateForeground(
            onPrimary: onPrimary,
            onSurface: onSurface,
            onFail: onFail,
            onSuccess: onSuccess,
            onDisable: onDisable,
          );

    return style.copyWith(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  /// Default StateButton style
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(horizontal: 16),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );

    return styleFrom(
      primary: colorScheme.primary,
      onPrimary: colorScheme.onPrimary,
      onSurface: colorScheme.onSurface,
      fail: colorScheme.primary,
      onFail: colorScheme.onPrimary,
      success: colorScheme.primary,
      onSuccess: colorScheme.onPrimary,
      shadowColor: theme.shadowColor,
      elevation: 2,
      textStyle: theme.textTheme.button,
      padding: scaledPadding,
      minimumSize: const Size(64, 36),
      maximumSize: Size.infinite,
      side: null,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }

  @override
  State<StatefulWidget> createState() => _StateButton();
}

class _StateButton extends State<StateButton>
    with CustomState<StateButton, ButtonState> {
  bool get _disable => disable(customState);

  @override
  void initState() {
    super.initState();
    customState = widget.states ?? {ButtonState.initial};
  }

  @override
  Widget build(BuildContext context) {
    if (widget.states != null) {
      customState = widget.states!;
    }

    final widgetStyle = widget.style;
    final themeStyle = Theme.of(context).elevatedButtonTheme.style;
    final defaultStyle = widget.defaultStyleOf(context);
    final style = widgetStyle ?? themeStyle ?? defaultStyle;

    final bg = style.backgroundColor as _StateBackground?;
    final fg = style.foregroundColor as _StateForeground?;
    final finalStyle = style.copyWith(
        backgroundColor: bg?.withState(customState),
        foregroundColor: fg?.withState(customState));
    final fgColor = style.foregroundColor?.resolve({}) ??
        themeStyle?.foregroundColor?.resolve({}) ??
        defaultStyle.foregroundColor?.resolve({});

    final icon = _buildIcon();
    if (icon != null) {
      return AbsorbPointer(
        absorbing: _disable,
        child: ElevatedButton.icon(
          onPressed: _disable ? () {} : () => widget.onTap(this),
          icon: icon,
          label: _buildWidget(fgColor),
          style: finalStyle,
        ),
      );
    } else {
      return AbsorbPointer(
        absorbing: _disable,
        child: ElevatedButton(
          onPressed: _disable ? () {} : () => widget.onTap(this),
          child: _buildWidget(fgColor),
          style: finalStyle,
        ),
      );
    }
  }

  Widget _buildWidget(Color? fg) {
    if (customState.contains(ButtonState.progressing)) {
      return widget.loader ??
          Transform.scale(
              scale: 0.6,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color?>(fg),
              ));
    } else if (customState.contains(ButtonState.forceDisabled)) {
      return widget.disable ?? widget.initial;
    } else if (customState.contains(ButtonState.success)) {
      return widget.success ?? widget.initial;
    } else if (customState.contains(ButtonState.fail)) {
      return widget.fail ?? widget.initial;
    }
    return widget.initial;
  }

  Widget? _buildIcon() {
    if (customState.contains(ButtonState.progressing)) {
      return widget.loaderIcon ?? widget.icon;
    } else if (customState.contains(ButtonState.forceDisabled)) {
      return widget.disableIcon ?? widget.icon;
    } else if (customState.contains(ButtonState.success)) {
      return widget.successIcon ?? widget.icon;
    } else if (customState.contains(ButtonState.fail)) {
      return widget.failIcon ?? widget.icon;
    }
    return widget.icon;
  }
}

@immutable
class _StateBackground extends MaterialStateProperty<Color?>
    with Diagnosticable, ButtonStateProperty<Color?> {
  _StateBackground({
    this.primary,
    this.onSurface,
    this.fail,
    this.success,
    this.disable,
    this.buttonState = const {},
  });

  final Color? primary;
  final Color? onSurface;
  final Color? success;
  final Color? fail;
  final Color? disable;
  final Set<ButtonState> buttonState;

  @override
  Color? resolve(Set<dynamic> states) {
    var color = resolveProp(buttonState);
    if (states.contains(MaterialState.disabled) ||
        buttonState.contains(ButtonState.disabled)) {
      return (color ?? onSurface)?.withOpacity(0.08);
    }
    return color ?? primary;
  }

  @override
  _StateBackground withState(Set<ButtonState> states) => _StateBackground(
      primary: primary,
      onSurface: onSurface,
      success: success,
      fail: fail,
      disable: disable,
      buttonState: states);

  @override
  Color? resolveProp(Set<ButtonState> states) {
    Color? color;
    if (buttonState.contains(ButtonState.forceDisabled)) {
      color = disable;
    } else if (buttonState.contains(ButtonState.fail)) {
      color = fail;
    } else if (buttonState.contains(ButtonState.success)) {
      color = success;
    }
    return color;
  }
}

@immutable
class _StateForeground extends MaterialStateProperty<Color?>
    with Diagnosticable, ButtonStateProperty<Color?> {
  _StateForeground(
      {this.onPrimary,
      this.onSurface,
      this.onFail,
      this.onSuccess,
      this.onDisable,
      this.buttonState = const {}});

  final Color? onPrimary;
  final Color? onSurface;
  final Color? onSuccess;
  final Color? onFail;
  final Color? onDisable;
  final Set<ButtonState> buttonState;

  @override
  Color? resolve(Set<MaterialState> states) {
    var color = resolveProp(buttonState);

    if (disableAlpha(states, buttonState)) {
      return (color ?? onSurface)?.withOpacity(0.38);
    }
    return color ?? onPrimary;
  }

  @override
  _StateForeground withState(Set<ButtonState> states) => _StateForeground(
      onSuccess: onSurface,
      onSurface: onSurface,
      onPrimary: onPrimary,
      onDisable: onDisable,
      onFail: onFail,
      buttonState: states);

  @override
  Color? resolveProp(Set<ButtonState> states) {
    Color? color;
    if (states.contains(ButtonState.forceDisabled)) {
      color = onDisable;
    } else if (states.contains(ButtonState.fail)) {
      color = onFail;
    } else if (states.contains(ButtonState.success)) {
      color = onSuccess;
    }
    return color;
  }
}
