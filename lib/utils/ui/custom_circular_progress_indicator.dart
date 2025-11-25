import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final bool enabled;
  final Widget? child;
  final Color? color;
  const CustomCircularProgressIndicator({
    super.key,
    this.color,
    this.enabled = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? Container();
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: color ?? Colors.black,
          strokeWidth: 2,
        ),
      );
    }
  }
}
