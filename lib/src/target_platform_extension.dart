import 'package:flutter/foundation.dart';

import '../platform_detail.dart';

/// Extension to convert from Flutter's TargetPlatform to PlatformType.
extension PlatformTypeParser on TargetPlatform {
  PlatformType toPlatformType() {
    switch (this) {
      case TargetPlatform.android:
        return PlatformType.android;
      case TargetPlatform.iOS:
        return PlatformType.iOS;
      case TargetPlatform.macOS:
        return PlatformType.macOS;
      case TargetPlatform.windows:
        return PlatformType.windows;
      case TargetPlatform.linux:
        return PlatformType.linux;
      case TargetPlatform.fuchsia:
        return PlatformType.fuchsia;
    }
  }
}
