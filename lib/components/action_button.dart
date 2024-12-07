import 'package:flutter/material.dart';
import 'package:merchant/util/Constants.dart';

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    this.onPressed,
    this.color=KPrimaryColor,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Color color;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: color,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: color,
      ),
    );
  }
}