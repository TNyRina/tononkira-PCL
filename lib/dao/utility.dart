
import 'package:flutter/foundation.dart' as fondation;

void logError(String message, Object error, StackTrace stack) {
    if (fondation.kDebugMode) {
      print("$message : $error");
    }
    fondation.FlutterError.reportError(
      fondation.FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: "LyricDAO",
        context: fondation.ErrorDescription(message),
      ),
    );
  }