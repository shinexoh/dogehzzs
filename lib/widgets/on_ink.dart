import 'package:flutter/material.dart';

class OnInk extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final bool? splashFactory;
  final Widget? child;

  const OnInk({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.splashFactory,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: InkWell(
          splashFactory: splashFactory ?? false ? null : NoSplash.splashFactory,
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}
