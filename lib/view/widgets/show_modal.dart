import 'package:flutter/material.dart';

Future<T?> showModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isDismissible = true,
  bool enableDrag = true,
  AnimationController? transitionAnimationController,
}) {
  return showModalBottomSheet(
    context: context,
    builder: builder,
    constraints: constraints,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
    ),
    isScrollControlled: true,
    barrierColor: barrierColor,
    isDismissible: isDismissible,
    backgroundColor: backgroundColor,
    enableDrag: enableDrag,
    transitionAnimationController: transitionAnimationController,
    elevation: elevation,
  );
}
