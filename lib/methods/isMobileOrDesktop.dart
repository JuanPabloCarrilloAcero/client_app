import 'package:flutter/foundation.dart';

bool isMobileOrDesktop() {
  if (kIsWeb) {
    // If the app is running in a web browser, treat it as a desktop
    return true;
  } else {
    // For other platforms, check if it's a desktop platform (e.g., Windows, macOS, Linux)
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows;
  }
}