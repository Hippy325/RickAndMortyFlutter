import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/ui/error_alert.dart';

showErrorAlert({
  required BuildContext context,
  required String error,
  void Function()? then,
}) {
  Future.delayed(
    Duration.zero,
    () {
      showDialog(
        context: context,
        builder: (context) {
          return ErrorAlert(content: error);
        },
      ).then(
        (value) {
          then?.call();
        },
      );
    },
  );
}
