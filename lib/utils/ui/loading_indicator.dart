import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/ui/custom_circular_progress_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  final bool? initialLoading;
  final bool? loading;
  final Widget child;

  const LoadingIndicator({
    super.key,
    this.initialLoading,
    this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (initialLoading == true) {
      return const CustomCircularProgressIndicator();
    } else {
      return Stack(
        children: [
          Opacity(
            opacity: loading == true ? 0.5 : 1.0,
            child: child,
          ),
          if (loading == true)
            AbsorbPointer(
              absorbing: true, // Блокируем все взаимодействия
              child: Container(
                color: Colors.transparent,
              ),
            ),
          if (loading == true) const CustomCircularProgressIndicator()
        ],
      );
    }
  }
}
