import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void notification(BuildContext context, String message, [ToastificationType type = ToastificationType.success]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      toastification.show(
        type: type,
        context: context,
        title: Text(message),
        autoCloseDuration: const Duration(seconds: 3),
      );
    });
  }